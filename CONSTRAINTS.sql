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
        RAISE EXCEPTION 'El importe de un comprobante debe coincidir con la suma de los importes de sus líneas'
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
        RAISE EXCEPTION 'El importe de un comprobante debe coincidir con la suma de los importes de sus líneas'
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





delete from comprobante where id_comp = 1 and id_tcomp = 100;

insert into comprobante (id_comp, id_tcomp, fecha, comentario, estado, fecha_vencimiento, id_turno, importe, id_cliente)  values
                        (1,100,'Jan 01, 2010','comentario',null,'Jan 01, 2015',80,200,3);

insert into lineacomprobante (nro_linea, id_comp, id_tcomp, descripcion, cantidad, importe, id_servicio) values
                                (400134,01,100,'descripcion',2,2000,301);

