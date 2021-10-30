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


--INSERT
CREATE OR REPLACE FUNCTION Insert_V_Servicios_activos_por_cliente() RETURNS TRIGGER AS $$
BEGIN

  INSERT INTO servicio (id_servicio, nombre, periodico, costo, intervalo, tipo_intervalo, activo, id_cat)
  VALUES (new.id_servicio, new.nombre, new.periodico, new.costo, new.intervalo, new.tipo_intervalo, new.activo, new.id_cat);

  INSERT INTO Cliente (id_cliente, saldo)
  VALUES (new.id_cliente, new.saldo);

  RETURN NEW;

END
$$ LANGUAGE plpgsql;

CREATE TRIGGER  tr_Insert_V_Servicios_activos_por_cliente
INSTEAD OF INSERT ON V_Servicios_activos_por_cliente
FOR EACH ROW EXECUTE PROCEDURE Insert_V_Servicios_activos_por_cliente();

INSERT INTO V_Servicios_activos_por_cliente (id_cliente, id_servicio, costo)
VALUES (id_servicio, costo, id_cliente);
