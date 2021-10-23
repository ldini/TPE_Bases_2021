--Inserciones necessarias para comprobar la consulta 1.a)

--El id_persona es del rango 0 en adelante
INSERT INTO persona (id_persona, tipo, tipodoc, nrodoc, nombre, apellido, fecha_nacimiento, fecha_baja, cuit, activo)
VALUES (1,'H','DNI',1111,'Pers1','Ejem1','Mar 26, 1998',NULL,01111,'1');

INSERT INTO persona (id_persona, tipo, tipodoc, nrodoc, nombre, apellido, fecha_nacimiento, fecha_baja, cuit, activo)
VALUES (2,'M','DNI',1112,'Pers2','Ejem1','Jul 01, 1999',NULL,01112,'1');

INSERT INTO persona (id_persona, tipo, tipodoc, nrodoc, nombre, apellido, fecha_nacimiento, fecha_baja, cuit, activo)
VALUES (3,'M','DNI',1113,'Pers3','Ejem2','Dec 13, 1985','May 26, 2005',01113,'0');

INSERT INTO cliente (id_cliente, saldo)
VALUES (1,NULL);

INSERT INTO cliente (id_cliente, saldo)
VALUES (2,100);

INSERT INTO cliente (id_cliente, saldo)
VALUES (3,150);


--El id_servicio es del rango de 300 en adelante.
INSERT INTO servicio (id_servicio, nombre, periodico, costo, intervalo, tipo_intervalo, activo, id_cat)
VALUES(301,'Serv1','0',100,5,'mes','0',1);

INSERT INTO servicio (id_servicio, nombre, periodico, costo, intervalo, tipo_intervalo, activo, id_cat)
VALUES(302,'Serv2','1',100,5,'mes','1',1);

INSERT INTO categoria (id_cat, nombre)
VALUES(1,'Cat1');

INSERT INTO equipo (id_equipo, nombre, mac, ip, ap, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
VALUES(101,'Equipo1','0101','1.1','2.1',301,1,'Jan 01, 2010',NULL,'Cable','A');

INSERT INTO equipo (id_equipo, nombre, mac, ip, ap, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
VALUES(102,'Equipo2','0102','1.2','2.2',301,1,'Jan 01, 2010',NULL,'Cable','A');

INSERT INTO equipo (id_equipo, nombre, mac, ip, ap, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
VALUES(103,'Equipo3','0103','1.3','2.3',302,2,'May 05, 2009',NULL,'Cable','B');

INSERT INTO equipo (id_equipo, nombre, mac, ip, ap, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
VALUES(104,'Equipo4','0104','1.4','2.4',302,2,'May 05, 2009',NULL,'Cable','B');

INSERT INTO equipo (id_equipo, nombre, mac, ip, ap, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
VALUES(105,'Equipo5','0105','1.5','2.5',302,2,'Jun 05, 2009',NULL,'ADSL','C');

INSERT INTO equipo (id_equipo, nombre, mac, ip, ap, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
VALUES(106,'Equipo6','0106','1.6','2.6',301,3,'Jan 01, 2002','May 26, 2005','ADSL','A');

--Inserciones necesarias para comprobar la consulta 1.b)

INSERT INTO ciudad (id_ciudad, nombre)
VALUES (401, 'Balcarce');

INSERT INTO ciudad (id_ciudad, nombre)
VALUES (402, 'Tandil');

INSERT INTO barrio (id_barrio, nombre, id_ciudad)
VALUES (501, 'Barrio1',401);

INSERT INTO barrio (id_barrio, nombre, id_ciudad)
VALUES (502, 'Barrio2',402);

INSERT INTO direccion (id_direccion, id_persona, calle, numero, piso, depto, id_barrio)
VALUES (601,1,'Mitre',500,NULL,NULL,502);

INSERT INTO direccion (id_direccion, id_persona, calle, numero, piso, depto, id_barrio)
VALUES (602,2,'Mitre',500,NULL,NULL,502);

INSERT INTO direccion (id_direccion, id_persona, calle, numero, piso, depto, id_barrio)
VALUES (603,3,'Av.Kelly',750,NULL,NULL,501);

INSERT INTO equipo (id_equipo, nombre, mac, ip, ap, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
VALUES(107,'Equipo7','0107','1.7','2.7',301,2,'Jan 01, 2020','Jan 01,2021','ADSL','B') ;

