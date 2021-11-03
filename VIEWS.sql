-- ** 3.a **
-- Realice una vista que contenga el saldo de cada uno de los clientes que tengan domicilio en la ciudad ‘X’.

CREATE OR REPLACE VIEW V_Saldo_ciudad AS
SELECT c.id_cliente, c.saldo
FROM cliente c
WHERE id_cliente IN (SELECT d.id_persona
                    FROM ciudad c
                    JOIN barrio b on c.id_ciudad = b.id_ciudad
                    JOIN direccion d on b.id_barrio = d.id_barrio
                    WHERE c.nombre like 'Tandil')

WITH LOCAL CHECK OPTION;

--DROP VIEW V_Saldo_ciudad;

--SELECT * FROM V_Saldo_ciudad;


--SIN CHECK OPTION
INSERT INTO V_Saldo_ciudad (id_cliente, saldo) VALUES  (7, 7000); --Cumple la condicion del WHERE, se inserta en la tabla cliente y se refleja en la vista.
INSERT INTO V_Saldo_ciudad (id_cliente, saldo) VALUES  (8, 1500); --Se produce migracion de tupla. Se inserta en la tabla cliente pero no se refleja en la vista.


--CON LOCAL CHECK OPTION
INSERT INTO V_Saldo_ciudad (id_cliente, saldo) VALUES  (7, 7000); --Cumple la condicion del WHERE, se inserta en la tabla cliente y se refleja en la vista.
INSERT INTO V_Saldo_ciudad (id_cliente, saldo) VALUES  (8, 1500); --Viola la condicion del check option, no se inserta.



--***********************************************************************************************************************************************

--** 3.b **
-- Realice una vista con la lista de servicios activos que posee cada cliente junto con el costo del mismo al momento de consultar la vista.

CREATE OR REPLACE VIEW V_Servicios_activos_por_cliente AS
    SELECT DISTINCT e.id_cliente, s.id_servicio, s.costo
    FROM servicio s
        JOIN equipo e on s.id_servicio = e.id_servicio
    WHERE s.activo = '1'
    ORDER BY e.id_cliente;

--SELECT * FROM V_Servicios_activos_por_cliente;

-- // La vista no es actualizable debido al uso de JOIN y DISTINCT//

-- // Para poder realizar un INSERT en la vista, esta debe tener en el SELECT al menos todos los atributos NOT NULL de las tablas referenciadas.//
-- // No se puede realizar un UPDATE en el atributo "activo" porque no se encuentra en el SELECT de la vista.//
--


/* PARA PROBAR QUE NO SE PUEDE HACER UPDATE
--UPDATE
CREATE OR REPLACE FUNCTION UPDATE_V_Servicios_activos_por_cliente() RETURNS TRIGGER AS $$
BEGIN
    UPDATE servicio SET activo = new.activo WHERE id_servicio = new.id_servicio;
  RETURN NEW;

END
$$ LANGUAGE plpgsql;

CREATE TRIGGER  tr_UPDATE_V_Servicios_activos_por_cliente
INSTEAD OF UPDATE ON V_Servicios_activos_por_cliente
FOR EACH ROW EXECUTE PROCEDURE UPDATE_V_Servicios_activos_por_cliente();

UPDATE V_Servicios_activos_por_cliente SET activo = '0' WHERE id_servicio = 303;*/


--***********************************************************************************************************************************************

--** 3.c **
-- Realice una vista que contenga, por cada uno de los servicios periódicos registrados, el monto facturado mensualmente
-- durante los últimos 5 años ordenado por servicio, año, mes y monto.

CREATE OR REPLACE VIEW V_Monto_mensual_serviciosPeriodicos AS
SELECT s.id_servicio, EXTRACT (MONTH FROM c.fecha) AS mes,EXTRACT (YEAR FROM c.fecha) AS año, SUM(l.importe)
FROM comprobante c
    JOIN lineacomprobante l on c.id_comp = l.id_comp and c.id_tcomp = l.id_tcomp
    JOIN servicio s on l.id_servicio = s.id_servicio
WHERE EXTRACT (YEAR FROM c.fecha) > EXTRACT (YEAR FROM CURRENT_DATE)-5 AND s.periodico = '1'
GROUP BY s.id_servicio, año, mes
ORDER BY año;

--SELECT * FROM V_Monto_mensual_serviciosPeriodicos;

--*********************************************** REVISAR *********************************************************
-- // Para poder realizar un INSERT en la vista, esta debe tener en el SELECT al menos todos los atributos NOT NULL de las tablas referenciadas y sus PK completas//
-- // No se puede realizar un UPDATE. //
