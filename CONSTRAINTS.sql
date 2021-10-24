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
El importe de un comprobante debe coincidir con la suma de los importes de sus líneas
(si las tuviera).*/

--Esta reestriccion es entre tablas, por lo tanto no se puede resolver de forma declarativa.

--Forma declarativa(lo pide el enunciado):
/*
ALTER TABLE comprobante CHECK(
    NOT EXISTS( SELECT 1
                FROM comprobante c
                WHERE c.importe <> (
                    SELECT SUM(l.importe)
                    FROM LineaComprobante l
                    WHERE c.id_comp=l.id_comp AND c.id_tcomp = l.id_tcomp
                    )
            )
    )*/

CREATE OR REPLACE function tr_comprobante_sumaimportes() RETURNS trigger AS $$
BEGIN
    IF (EXISTS (SELECT 1
            FROM comprobante c
            WHERE c.importe <> (SELECT SUM(l.importe)
                                FROM lineacomprobante l
                                WHERE c.id_comp=l.id_comp
                                        AND c.id_tcomp=l.id_tcomp)
       )) THEN
        RAISE EXCEPTION 'trigger: tr_comproobante_sumaimportes activado'
    END IF;
END $$
language 'plpgsql'; --No esta terminado
