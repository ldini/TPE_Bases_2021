-- 4.a) Proveer el mecanismo que crea más adecuado para que al ser invocado (una vez por mes), tome todos los servicios
-- que son periódicos y genere la/s factura/s correspondiente/s. Indicar si se deben proveer parámetros adicionales para su generación.
-- Explicar además cómo resolvería el tema de la invocación mensual (pero no lo implemente).

CREATE OR REPLACE PROCEDURE generar_facturacion() AS $$
    DECLARE
        var_cliente int;
    BEGIN
        FOR var_cliente IN (SELECT DISTINCT e.id_cliente
                            FROM equipo e) --Por todos los clientes activos(que tienen equipo), genero la factura.
        LOOP
            call generar_facturaPorCliente(var_cliente);
        END LOOP;
    END;
$$ language 'plpgsql';

CREATE OR REPLACE PROCEDURE generar_facturaPorCliente(param_idCliente int) AS $$
    DECLARE
        var_comp comprobante;
        rec_service record;
        var_nroLinea int = 0;
    BEGIN
        var_comp.id_comp = (SELECT max(c.id_comp)
                            FROM comprobante c
                            LIMIT 1) +1;
        var_comp.id_tcomp = 1; --1 equivale a tipo factura
        var_comp.fecha = current_timestamp;
        var_comp.comentario = 'Facturacion mensual';
        var_comp.estado = null;
        var_comp.fecha_vencimiento = null; -- Podria ponerle la fecha de vencimiento con (current_timestamp + interval '1 month')::timestamp;
        var_comp.id_turno = null;
        var_comp.importe = 0;
        var_comp.id_cliente = param_idCliente;

        IF EXISTS (SELECT 1 FROM equipo e JOIN servicio s on e.id_servicio = s.id_servicio
                    WHERE s.periodico = 'true' AND e.id_cliente = var_comp.id_cliente) THEN --Comprueba si el cliente posee algun servicio periodico antes de crear un comprobante

            INSERT INTO comprobante(id_comp, id_tcomp, fecha, comentario, estado, fecha_vencimiento, id_turno, importe, id_cliente)
                    VALUES (var_comp.id_comp,var_comp.id_tcomp, var_comp.fecha, var_comp.comentario, var_comp.estado,
                            var_comp.fecha_vencimiento, var_comp.id_turno,var_comp.importe,var_comp.id_cliente);

            FOR rec_service IN (SELECT s.id_servicio, s.costo, s.nombre FROM servicio s
                                WHERE s.id_servicio IN (SELECT e.id_servicio FROM equipo e
                                                        WHERE e.id_cliente = var_comp.id_cliente))
            LOOP
                call generar_lineasFactura(var_comp,rec_service, var_nroLinea);
                var_nroLinea = var_nroLinea+1;
            END LOOP;

        END IF;
    END;
$$language plpgsql;


CREATE OR REPLACE PROCEDURE generar_lineasFactura(param_comprobante comprobante, param_recServicio record, param_nroLinea int) AS $$
    DECLARE
        linea lineacomprobante;
    BEGIN
        linea.nro_linea = param_nroLinea;
        linea.id_comp = param_comprobante.id_comp;
        linea.id_tcomp = param_comprobante.id_tcomp;
        linea.descripcion = param_recServicio.nombre;
        linea.cantidad = 1;
        linea.importe = param_recServicio.costo;
        linea.id_servicio= param_recServicio.id_servicio;
        param_comprobante.importe = param_comprobante.importe + linea.importe;

        UPDATE comprobante SET importe = importe + param_comprobante.importe
                WHERE comprobante.id_tcomp = param_comprobante.id_tcomp
                                            AND comprobante.id_comp = param_comprobante.id_comp;

        INSERT INTO lineacomprobante(nro_linea, id_comp, id_tcomp, descripcion, cantidad, importe, id_servicio)
                VALUES(linea.nro_linea, linea.id_comp, linea.id_tcomp,linea.descripcion,linea.cantidad,
                       linea.importe,linea.id_servicio);
    END;
$$language plpgsql;

call generar_facturacion();

/*
    Para realizar la invocacion mensual del procedimiento utilizariamos el Task Scheduler de Windows, en el cual
    creariamos una tarea que se inicie mensualmente y ejecute el siguiente comando:
    psql -U {username} -d {databasename} -w -c 'call generar_facturacion()'
*/


-----------------------------------------------------------------------------------------------------------------------

--4.b) Proveer el mecanismo que crea más adecuado para que al ser invocado retorne el inventario consolidado de los equipos actualmente utilizados.
-- Se necesita un listado que por lo menos tenga: el nombre del equipo, el tipo, cantidad y si lo considera necesario puede agregar más datos.
CREATE OR REPLACE VIEW inventario_consolidado_equipo as
    select e.nombre, e.tipo_conexion, e.tipo_asignacion,count(*) as CantEquipos
    from equipo e
    where e.fecha_baja is null
    group by e.tipo_conexion, e.tipo_asignacion,e.nombre;

--select * from inventario_consolidado_equipo;


-----------------------------------------------------------------------------------------------------------------------

--4.c)
-- Proveer el mecanismo que crea más adecuado para que al ser invocado entre dos fechas cualesquiera dé un informe de los empleados
-- junto con la cantidad de turnos resueltos por localidad (ciudad) y los tiempos promedio y máximo del conjunto de cada uno.

DROP FUNCTION informe_empleados_BTWDates;

CREATE OR REPLACE FUNCTION informe_empleados_BTWDates(fecha_inicio timestamp, fecha_fin timestamp)
    RETURNS table(id_personal int,ciudad varchar, cantidad bigint, tiempo_promedio interval, timepo_maximo interval) as
    $$
        BEGIN
            return query(
                SELECT p.id_personal, c.nombre,count(turno.id_turno)cantidadTurnosResueltos
                        ,AVG(turno.hasta - turno.desde),MAX(turno.hasta-turno.desde)
                FROM (  select personal.id_personal
                        from personal
                        where personal.id_rol in (SELECT r.id_rol FROM rol r WHERE r.nombre = 'Empleado')) p
                    JOIN(   SELECT t.id_personal,t.id_turno,t.hasta,t.desde
                            FROM turno t
                            WHERE (t.hasta is not null AND (fecha_inicio <= t.desde
                                       AND fecha_fin >= t.hasta)
                                      )) turno on p.id_personal = turno.id_personal
                    JOIN direccion d on p.id_personal=d.id_persona
                    JOIN barrio b on d.id_barrio = b.id_barrio
                    JOIN ciudad c on c.id_ciudad = b.id_ciudad
                    GROUP BY p.id_personal,c.nombre);
        END;
    $$language plpgsql;

select * from informe_empleados_BTWDates((to_timestamp('2010-01-01','YYYY-dd-mm')::timestamp),to_timestamp('2012-01-01','YYYY-dd-mm')::timestamp);
