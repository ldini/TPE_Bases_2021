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
