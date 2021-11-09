-- a. Proveer el mecanismo que crea más adecuado para que al ser invocado (una vez por mes), tome todos los servicios
-- que son periódicos y genere la/s factura/s correspondiente/s. Indicar si se deben proveer parámetros adicionales para su generación. Explicar además cómo resolvería el tema de la invocación mensual (pero no lo implemente).

SELECT e.id_cliente,s.id_servicio,s.costo
    FROM equipo e
    JOIN ( SELECT id_servicio,costo
            FROM servicio
            WHERE periodico='1') s on e.id_servicio = s.id_servicio;

CREATE OR REPLACE VIEW servicios_ClientesActivos AS
    SELECT e.id_cliente, s.id_servicio, s.costo, s.nombre
    FROM equipo e
        JOIN (select id_servicio,costo,nombre from servicio where periodico='1' AND activo='1')
            s on e.id_servicio = s.id_servicio;

SELECT * FROM servicios_ClientesActivos;

CREATE OR REPLACE FUNCTION facturacionPorCliente(id_cliente int)
    returns comprobante as
    $$
        DECLARE
            factura comprobante;
            lineas lineacomprobante;
            rec record;
        BEGIN
                for rec in (SELECT * FROM servicios_ClientesActivos) loop
                    
                end loop;

            return factura;
        end;
    $$ language 'plpgsql';


--4.b)
CREATE OR REPLACE VIEW inventario_consolidado_equipo as
    select e.nombre, e.tipo_conexion, e.tipo_asignacion,count(*) as CantEquipos
    from equipo e
    where e.fecha_baja is null
    group by e.tipo_conexion, e.tipo_asignacion,e.nombre;

select * from inventario_consolidado_equipo;

--4.c)
DROP FUNCTION informe_empleados_BTWDates;
CREATE OR REPLACE FUNCTION informe_empleados_BTWDates(fecha_inicio timestamp, fecha_fin timestamp)
    RETURNS table(id_personal int,id_ciudad int, cantidad bigint, promedioHs double precision, max double precision) as
    $$
        BEGIN
            return query
                SELECT p.id_personal, b.id_ciudad,count(turno.id_turno)cantidadTurnosResueltos,
                        AVG(EXTRACT(epoch from(turno.hasta - turno.desde))/3600),MAX(EXTRACT(epoch from(turno.hasta-turno.desde)))
                FROM (  select personal.id_personal
                        from personal
                        where personal.id_personal='1') p --se entiende que el id_rol='1' es el rol de empleado
                    JOIN(   SELECT t.id_personal,t.id_turno,t.hasta,t.desde
                            FROM turno t
                            WHERE (t.hasta is not null AND (fecha_inicio <= t.desde
                                                        AND fecha_fin <= t.hasta))
                        ) turno on p.id_personal = turno.id_personal
                    JOIN (  SELECT c.id_turno, c.id_cliente
                            FROM comprobante c
                         ) comprobante on turno.id_turno=comprobante.id_turno
                    JOIN direccion d on comprobante.id_cliente=d.id_persona
                    JOIN barrio b on d.id_barrio = b.id_barrio
                    GROUP BY p.id_personal,b.id_ciudad;
        END;
    $$language plpgsql;

select * from informe_empleados_BTWDates((to_timestamp('2010-01-01','YYYY-dd-mm')::timestamp),to_timestamp('2012-01-01','YYYY-dd-mm')::timestamp);
