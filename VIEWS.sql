-- ** a **
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



DROP VIEW V_Saldo_ciudad;

SELECT *
FROM V_Saldo_ciudad;


--SIN CHECK OPTION
INSERT INTO V_Saldo_ciudad (id_cliente, saldo) VALUES  (7, 7000); --Cumple la condicion del WHERE, se inserta en la tabla cliente y se refleja en la vista.
INSERT INTO V_Saldo_ciudad (id_cliente, saldo) VALUES  (8, 1500); --Se produce migracion de tupla. Se inserta en la tabla cliente pero no se refleja en la vista.


--CON LOCAL CHECK OPTION
INSERT INTO V_Saldo_ciudad (id_cliente, saldo) VALUES  (7, 7000); --Cumple la condicion del WHERE, se inserta en la tabla cliente y se refleja en la vista.
INSERT INTO V_Saldo_ciudad (id_cliente, saldo) VALUES  (8, 1500); --Viola la condicion del check option, no se inserta.

