--***********************************************************************************************************************************************
--** a **
/*Si una persona está inactiva debe tener establecida una fecha de baja, la cual se debe controlar que sea al
menos 18 años posterior a la de nacimiento.*/

ALTER TABLE Persona
ADD CONSTRAINT pk_persona_inactiva
CHECK ((activo=false
    AND fecha_baja is not null
    AND (extract(YEAR from fecha_baja)-extract(YEAR from fecha_nacimiento))>=18 )
    OR (activo = true)
    );


--***********************************************************************************************************************************************

/** b **
El importe de un comprobante debe coincidir con la suma de los importes de sus líneas (si las tuviera).*/

--Forma declarativa(lo pide el enunciado):
/*
ALTER TABLE comprobante CHECK(
    NOT EXISTS( SELECT 1
                FROM comprobante c
                WHERE c.importe <> (
                    SELECT SUM(l.importe)
                    FROM LineaComprobante l
                    WHERE c.id_comp = l.id_comp AND c.id_tcomp = l.id_tcomp
                    )
            )
    )*/


--***********************************************************************************************************************************************
--** c **
--Un equipo puede tener asignada un IP, y en este caso, la MAC resulta requerida.

--Forma declarativa
/*
CREATE ASSERTION ass_check_MACRequerida CHECK(
    NOT EXISTS( SELECT 1
                FROM equipo e
                WHERE (e.IP is not null) AND
                      (e.MAC is null)
            )
    )*/

CREATE OR REPLACE function tr_insert_MACRequired() RETURNS trigger AS $$
BEGIN
    IF (EXISTS (SELECT 1
                FROM equipo e
                WHERE (e.ip is not null) AND (e.mac is null)
                )) THEN
        RAISE EXCEPTION 'Si se ingreso un IP es obligatorio ingresar una MAC';
    END IF;
    return new;
END; $$
language 'plpgsql';

create trigger insert_equipo_MACRequired
    after insert on equipo
    for each row execute procedure tr_insert_MACRequired();

CREATE OR REPLACE function tr_update_MACRequired() RETURNS trigger AS $$
BEGIN
    IF (EXISTS (SELECT 1
                FROM equipo e
                WHERE (e.ip<>new.ip) AND (new.mac is null)
                )) THEN
        RAISE EXCEPTION 'La nueva IP necesita que se declare una MAC.';
    END IF;
    return new;
END; $$
language 'plpgsql';

create trigger update_equipo_MACRequired
    after update of ip,id_cliente on equipo --esta bien que se comprueba el cliente?
    for each row execute procedure tr_update_MACRequired();


--***********************************************************************************************************************************************
--** d **
-- Las IPs asignadas a los equipos no pueden ser compartidas entre clientes.

--Forma declarativa
/*CREATE ASSERTION ass_ipCompartida CHECK(
    NOT EXISTS( SELECT 1
                FROM equipo e
                JOIN equipo e2 on e.ip = e2.ip
                WHERE e.id_cliente <> e2.id_cliente
    )*/

--Insert
CREATE OR REPLACE FUNCTION tr_insert_equipo_IPs() RETURNS trigger AS $$
BEGIN
    IF (EXISTS (SELECT 1
                FROM equipo e
                JOIN equipo e2 on e.ip = e2.ip
                WHERE e.id_cliente <> e2.id_cliente
       )) THEN
        RAISE EXCEPTION 'La IP pertenece a otro cliente';
    END IF;
    RETURN new;
END; $$
LANGUAGE 'plpgsql';

CREATE TRIGGER insert_equipo_IPs
    AFTER INSERT ON equipo
    FOR EACH ROW EXECUTE PROCEDURE tr_insert_equipo_IPs();


--Update
CREATE OR REPLACE FUNCTION tr_update_equipo_IPs() RETURNS trigger AS $$
BEGIN
    IF (EXISTS (SELECT 1
                FROM equipo e
                JOIN equipo e2 on e.ip = e2.ip
                WHERE e.id_cliente <> e2.id_cliente
                    AND new.id_equipo = e.id_equipo
       )) THEN
        RAISE EXCEPTION 'La IP pertenece a otro cliente';
    END IF;

    RETURN new;
END; $$
LANGUAGE 'plpgsql';

CREATE TRIGGER update_equipo_IPs
    AFTER UPDATE of ip, id_cliente ON equipo
    FOR EACH ROW EXECUTE PROCEDURE tr_update_equipo_IPs();


--***********************************************************************************************************************************************
--** e **
--No se pueden instalar más de 25 equipos por Barrio.

--Forma declarativa
/*
CREATE ASSERTION ass_limiteEquiposXBarrio CHECK (
    NOT EXISTS( SELECT 1
                FROM direccion d
                    JOIN equipo e on d.id_persona=e.id_cliente
                GROUP BY d.id_barrio
                HAVING count(e.id_equipo)>25
              )
    );
*/

--Insert
CREATE OR REPLACE FUNCTION tr_insert_cant_equipos_por_barrio() RETURNS trigger AS $$
BEGIN
    IF (EXISTS (SELECT 1
                FROM direccion d
                    JOIN equipo e on d.id_persona=e.id_cliente
                GROUP BY d.id_barrio
                HAVING count(e.id_equipo)>25

       )) THEN
        RAISE EXCEPTION 'No se pueden instalar más de 25 equipos por Barrio.';
    END IF;
    RETURN new;
END; $$
LANGUAGE 'plpgsql';

CREATE TRIGGER insert_cant_equipos_por_barrio
    AFTER INSERT ON equipo
    FOR EACH ROW EXECUTE PROCEDURE tr_insert_cant_equipos_por_barrio();

--Update
CREATE OR REPLACE FUNCTION tr_update_cant_equipos_por_barrio() RETURNS trigger AS $$
BEGIN
    IF (EXISTS (SELECT 1
                FROM direccion d
                    JOIN equipo e on d.id_persona=e.id_cliente
                WHERE new.id_cliente = e.id_cliente
                GROUP BY d.id_barrio
                HAVING count(e.id_equipo)>25

       )) THEN
        RAISE EXCEPTION 'No se pueden instalar más de 25 equipos por Barrio.';
    END IF;
    RETURN new;
END; $$
LANGUAGE 'plpgsql';


CREATE TRIGGER update_cantidad_equipos_por_barrio
    AFTER UPDATE OF id_cliente ON equipo
    FOR EACH ROW EXECUTE PROCEDURE tr_update_cant_equipos_por_barrio();





