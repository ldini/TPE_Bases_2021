/*a*/
/*Si una persona está inactiva debe tener establecida una fecha de baja, la cual se debe controlar que sea al
menos 18 años posterior a la de nacimiento.*/

ALTER TABLE Persona
ADD CONSTRAINT pk_persona_inactiva
CHECK ((activo=false
    AND fecha_baja is not null
    AND (extract(YEAR from fecha_baja)-extract(YEAR from fecha_nacimiento))>=18 )
    OR (activo = true)
    );

/***B***
El importe de un comprobante debe coincidir con la suma de los importes de sus líneas (si las tuviera).*/

--Esta reestriccion es entre tablas, por lo tanto no se puede resolver de forma declarativa.

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

--Insert
CREATE OR REPLACE function tr_insert_comprobante_sumaimportes() RETURNS trigger AS $$
BEGIN
    IF (EXISTS (SELECT 1
                FROM comprobante c
                WHERE c.importe <> (SELECT SUM(l.importe)
                                    FROM lineacomprobante l
                                    WHERE c.id_comp=l.id_comp
                                            AND c.id_tcomp=l.id_tcomp)
       )) THEN
        RAISE EXCEPTION 'El importe de un comprobante debe coincidir con la suma de los importes de sus líneas';
    END IF;
    return new;
END; $$
language 'plpgsql';

create trigger insert_comprobante_sumaimportes
    after insert on comprobante
    for each row execute procedure tr_insert_comprobante_sumaimportes();

create trigger insert_LineaComprobante_sumaimportes
    after insert on lineaComprobante
    for each row execute procedure tr_insert_comprobante_sumaimportes();

--Update
CREATE OR REPLACE function tr_update_comprobante_sumaimportes() RETURNS trigger AS $$
BEGIN
    IF (EXISTS (SELECT 1
                FROM comprobante c
                WHERE c.importe <> (SELECT SUM(l.importe)
                                    FROM lineacomprobante l
                                    WHERE c.id_comp=l.id_comp
                                            AND c.id_tcomp=l.id_tcomp)
                AND (new.id_comp = c.id_comp AND new.id_tcomp = c.id_tcomp)
       )) THEN
        RAISE EXCEPTION 'El importe de un comprobante debe coincidir con la suma de los importes de sus líneas';
    END IF;
    return new;
END; $$
language 'plpgsql';

create trigger update_comprobante_sumaimportes
    after update of importe on comprobante
    for each row execute procedure tr_update_comprobante_sumaimportes();

create trigger update_comprobante_sumaimportes
    after update of importe on lineacomprobante
    for each row execute procedure tr_update_comprobante_sumaimportes();


--PARA PROBAR LAS RESTRICCIONES
INSERT INTO comprobante (id_comp, id_tcomp, fecha, comentario, estado, fecha_vencimiento, id_turno, importe, id_cliente)  values
                        (01,100,'Jan 01, 2010','comentario',null,'Jan 01, 2015',80,200,3);
INSERT INTO lineacomprobante (nro_linea, id_comp, id_tcomp, descripcion, cantidad, importe, id_servicio) values
                                (400134,01,100,'descripcion',2,200,301);

UPDATE lineacomprobante set importe = 321 where id_comp = 01;
UPDATE comprobante set importe = 90 where id_comp = 01;

DELETE FROM lineacomprobante where id_comp = 01 and id_tcomp = 100; --¿Deberia existir un trigger para delete?
DELETE FROM comprobante where id_comp = 01 and id_tcomp = 100;



--**d**
-- Las IPs asignadas a los equipos no pueden ser compartidas entre clientes.

--Forma declarativa
/*ALTER TABLE equipo CHECK(
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


--PARA PROBAR LAS RESTRICCIONES
DELETE FROM equipo where id_equipo = 111;

INSERT INTO equipo (id_equipo, nombre, mac, ip, ap, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
VALUES(101,'Equipo1','0101','1.1','2.1',301,1,'Jan 01, 2010',NULL,'Cable','A');

INSERT INTO equipo (id_equipo, nombre, mac, ip, ap, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
            VALUES (111,'Equipo111','0101','1.2','2.1',301,2,'Jan 01, 2010',NULL,'Cable','A');

UPDATE equipo SET ip = '1.3' WHERE id_equipo = 101;




