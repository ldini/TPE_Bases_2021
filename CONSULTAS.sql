-- 1) CONSULTAS

/*Mostrar el listado de todos los clientes registrados en el sistema (id, apellido y nombre,
tipo y número de documento, fecha de nacimiento) junto con la
cantidad de equipos registrados que cada uno dispone, ordenado por apellido y nombre.*/

--a)
SELECT p.id_persona,p.nombre,p.apellido,p.tipodoc,p.nrodoc,p.fecha_nacimiento,cantidad_equipo.cantidad FROM cliente c
    JOIN persona p
        ON c.id_cliente = p.id_persona
    JOIN  (SELECT id_cliente, count(id_equipo) as cantidad FROM equipo
            GROUP BY id_cliente) as cantidad_equipo
        ON cantidad_equipo.id_cliente = c.id_cliente
ORDER BY p.apellido,p.nombre;

--b)
/*Realizar un ranking (de mayor a menor) de la cantidad de equipos instalados y aún activos, durante los últimos
24 meses, según su distribución geográfica, mostrando: nombre de ciudad, id de la ciudad, nombre del barrio,
id del barrio y cantidad de equipos.*/

SELECT ciudad.nombre,ciudad.id_ciudad,b.nombre,b.id_barrio,count(e.id_equipo) FROM ciudad
JOIN barrio b on ciudad.id_ciudad = b.id_ciudad
JOIN direccion d on b.id_barrio = d.id_barrio --> apartir de aca se podria aplicar IN o EXISTS para no usar join
JOIN persona p on d.id_persona = p.id_persona
JOIN cliente c on p.id_persona = c.id_cliente
JOIN equipo e on c.id_cliente = e.id_cliente --> hasta aca!
WHERE e.id_servicio IN (SELECT id_servicio FROM servicio
                        WHERE activo = true ) --> se considera 1 para activo y 0 para inactivo
AND AGE(e.fecha_alta) <= '2 year' --> durante los ultimos 24 meses, mas atras no se cuentan
/*AND to_date(e.fecha_baja,'dd,MM,yyyy') > to_date(current_date,'dd,MM,yyyy')*/ --> me aseguro que no sea haya dado de baja
GROUP BY ciudad.id_ciudad,b.id_barrio
ORDER BY count(e.id_equipo) DESC

/*c)
Visualizar el Top-3 de los lugares donde se ha realizado la mayor cantidad de servicios periódicos durante
los últimos 3 años.*/

SELECT * FROM comprobante
JOIN lineacomprobante ON comprobante.id_comp = lineacomprobante.id_comp and comprobante.id_tcomp = lineacomprobante.id_tcomp
                                    SELECT id_comp,id_tcomp FROM lineacomprobante l
                                    WHERE EXISTS(   SELECT id_servicio FROM servicio s
                                                WHERE periodico = true
                                                AND l.id_servicio = s.id_servicio
                                                AND s.id_servicio IS NOT NULL))
WHERE AGE(fecha) <= '3 year'

/*d*/
/*Indicar el nombre, apellido, tipo y número de documento de los clientes que han contratado todos los servicios periódicos cuyo intervalo se encuentra entre 5 y 10*/
SELECT nombre,apellido,tipo,nrodoc FROM persona
WHERE id_persona IN (
                    SELECT id_cliente FROM comprobante
                    WHERE id_comp IN (
                                        SELECT id_comp FROM lineacomprobante l
                                        WHERE EXISTS(SELECT 1 FROM servicio s
                                                        WHERE periodico = 1
                                                        AND intervalo BETWEEN 5 and 10
                                                        AND l.id_servicio = s.id_servicio)));













/*SELECT * FROM equipo
WHERE AGE(fecha_baja) <= '2 year'
AND id_servicio IN (SELECT id_servicio FROM servicio   -- hace falta saber si esta activo? porque si no tiene fecha
                        WHERE activo = 1)              -- de baja deberia estar activo?


SELECT DISTINCT id_persona FROM direccion
WHERE id_persona IN (SELECT id_cliente FROM equipo)
*/



