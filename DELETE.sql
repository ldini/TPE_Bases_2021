DELETE FROM equipo WHERE id_equipo IN (SELECT DISTINCT id_equipo FROM equipo);

DELETE FROM lineacomprobante WHERE nro_linea IN (SELECT DISTINCT nro_linea FROM lineacomprobante);

DELETE FROM servicio WHERE id_servicio IN (SELECT DISTINCT id_servicio FROM servicio);

DELETE FROM categoria WHERE id_cat IN (SELECT DISTINCT id_cat FROM categoria);

DELETE FROM servicio WHERE id_servicio IN (SELECT DISTINCT id_servicio FROM servicio);

DELETE FROM lineacomprobante WHERE nro_linea IN (SELECT DISTINCT nro_linea FROM lineacomprobante);

DELETE FROM comprobante WHERE id_comp IN (SELECT DISTINCT id_comp FROM comprobante);

DELETE FROM tipocomprobante WHERE id_tcomp IN (SELECT DISTINCT id_tcomp FROM tipocomprobante);

DELETE FROM cliente WHERE id_cliente IN (SELECT DISTINCT id_cliente FROM cliente);

DELETE FROM direccion WHERE id_direccion IN (SELECT DISTINCT id_direccion FROM direccion);

DELETE FROM telefono WHERE id_persona IN (SELECT DISTINCT id_persona FROM mail);

DELETE FROM mail WHERE id_persona IN (SELECT DISTINCT id_persona FROM mail);

DELETE FROM turno WHERE id_turno IN (SELECT DISTINCT id_turno FROM turno);

DELETE FROM personal WHERE id_personal IN (SELECT DISTINCT id_personal FROM personal);

DELETE FROM persona WHERE id_persona IN (select distinct id_persona from persona);

DELETE FROM barrio WHERE id_barrio IN (SELECT DISTINCT id_barrio FROM barrio);

DELETE FROM ciudad WHERE id_ciudad IN (SELECT DISTINCT id_ciudad FROM ciudad);

DELETE FROM cliente WHERE id_cliente IN (SELECT DISTINCT id_cliente FROM cliente);

DELETE FROM rol WHERE id_rol IN (SELECT DISTINCT id_rol FROM rol);







