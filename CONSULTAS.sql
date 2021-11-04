-- 1) CONSULTAS

--a)
/*Mostrar el listado de todos los clientes registrados en el sistema (id, apellido y nombre,
tipo y número de documento, fecha de nacimiento) junto con la
cantidad de equipos registrados que cada uno dispone, ordenado por apellido y nombre.*/
SELECT p.id_persona,p.nombre,p.apellido,p.tipodoc,p.nrodoc,p.fecha_nacimiento, cantidad_equipo
FROM persona p
    JOIN (  SELECT id_cliente,count(id_equipo) as cantidad
            FROM equipo
            GROUP BY id_cliente) as cantidad_equipo ON cantidad_equipo.id_cliente=p.id_persona
ORDER BY p.apellido,p.nombre;

--b)
/*Realizar un ranking (de mayor a menor) de la cantidad de equipos instalados y aún activos, durante los últimos
24 meses, según su distribución geográfica, mostrando: nombre de ciudad, id de la ciudad, nombre del barrio,
id del barrio y cantidad de equipos.*/

SELECT ciudad.nombre,ciudad.id_ciudad,b.nombre,b.id_barrio,count(e.id_equipo)
FROM ciudad
    JOIN barrio b on ciudad.id_ciudad = b.id_ciudad
    JOIN direccion d on b.id_barrio = d.id_barrio
    JOIN persona p on d.id_persona = p.id_persona
    JOIN equipo e on p.id_persona = e.id_cliente
WHERE (e.fecha_baja is NULL
      or (DATE_PART('year', CURRENT_DATE)-
          DATE_PART('year',(e.fecha_baja)::date)<=2))
GROUP BY ciudad.id_ciudad, b.id_barrio
ORDER BY count(e.id_equipo) DESC;

/*c)
Visualizar el Top-3 de los lugares donde se ha realizado la mayor cantidad de servicios periódicos durante
los últimos 3 años.*/

-- 2 maneras de encarar esta consulta:
-- Ciudad->Barrio->Direccion[con id_persona=id_cliente]->Cliente->Equipo->Servicio
-- Ciudad->Barrio->Direccion[con id_persona=id_cliente]->Comprobante->LineaComprobante->Servicio}

SELECT c.nombre, b.nombre, count(s.id_servicio)
FROM ciudad c
    JOIN barrio b on c.id_ciudad = b.id_ciudad
    join direccion d on b.id_barrio = d.id_barrio
    join equipo e on e.id_cliente=d.id_persona
    join servicio s on e.id_servicio = s.id_servicio
WHERE ((s.periodico=false) AND
        (DATE_PART('year',e.fecha_baja)
            BETWEEN date_part('year',CURRENT_DATE)
            AND date_part('year',current_date-3))
      )
GROUP BY c.nombre, b.nombre;

/*d*/
/*Indicar el nombre, apellido, tipo y número de documento de los clientes que han contratado todos los
  servicios periódicos cuyo intervalo se encuentra entre 5 y 10*/

SELECT p.nombre, p.apellido, p.tipo, p.nrodoc
FROM persona p
    JOIN equipo e on p.id_persona = e.id_cliente
    JOIN servicio s on e.id_servicio = s.id_servicio
WHERE (s.periodico=true
       AND s.intervalo BETWEEN 5 AND 10)
GROUP BY p.nombre, p.apellido, p.tipo, p.nrodoc;

