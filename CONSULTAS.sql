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

--FALTA TERMINAR
SELECT * FROM equipo
WHERE AGE(fecha_baja) <= '2 year'
AND id_servicio IN (SELECT id_servicio FROM servicio   -- hace falta saber si esta activo? porque si no tiene fecha
                        WHERE activo = 1)              -- de baja deberia estar activo?


SELECT DISTINCT id_persona FROM direccion
WHERE id_persona IN (SELECT id_cliente FROM equipo)

