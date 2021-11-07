--CIUDAD
INSERT INTO ciudad (id_ciudad, nombre) VALUES (1, 'Tandil');
INSERT INTO ciudad (id_ciudad, nombre) VALUES (2, 'Las Flores');
INSERT INTO ciudad (id_ciudad, nombre) VALUES (3, 'Necochea');
INSERT INTO ciudad (id_ciudad, nombre) VALUES (4, 'Mar Del Plata');

--BARRIO
INSERT INTO barrio(id_barrio, nombre, id_ciudad) VALUES (1, 'Los Nogales', 2);
INSERT INTO barrio(id_barrio, nombre, id_ciudad) VALUES (2, 'Centro', 1);
INSERT INTO barrio(id_barrio, nombre, id_ciudad) VALUES (3, 'Solidaridad', 2);
INSERT INTO barrio(id_barrio, nombre, id_ciudad) VALUES (4, 'Evita', 2);
INSERT INTO barrio(id_barrio, nombre, id_ciudad) VALUES (5, '25 De Mayo', 3);

--PERSONA
INSERT INTO persona (id_persona,tipo,tipodoc,nrodoc,nombre,apellido,fecha_nacimiento,fecha_baja,CUIT,activo)
VALUES
  (1,'Mujer','LC',1149410,'Courtney','Rocha','Feb 19, 1932','Feb 6, 1988',17760648,'0'),
  (2,'Hombre','DNI',26770950,'Signe','Owen','Sep 4, 1966',NULL,14957847,'1'),
  (3,'Hombre','DNI',25769634,'Penelope','Booker','Jan 5, 1961','Nov 24, 1997',34078935,'0'),
  (4,'Hombre','DNI',4088310,'Duncan','Delacruz','Mar 6, 2002',NULL,30479948,'1'),
  (5,'Hombre','DNI',9981733,'Bryar','Jennings','Aug 17, 1999','Oct 18, 2020',25735237,'0'),
  (6,'Hombre','LC',30056554,'Dean','Stein','Jun 7, 2000',NULL,15257777,'1'),
  (7,'Hombre','DNI',22293453,'Jena','Byrd','Dec 2, 1972','Sep 25, 1994',3313092,'0'),
  (8,'Hombre','DNI',1287866,'Harper','Stout','Nov 17, 1991',NULL,25161612,'1'),
  (9,'Hombre','DNI',17597284,'Kim','Hodge','Dec 24, 1979',NULL,10614747,'1'),
  (10,'Hombre','DNI',6581333,'Scarlett','Sparks','Jul 24, 2000','Mar 11, 2021',13779420,'0');

--DIRECCION
INSERT INTO direccion(id_direccion, id_persona, calle, numero, piso, depto, id_barrio) VALUES (1,1,'Belgrano', 679, NULL, NULL, 1);
INSERT INTO direccion(id_direccion, id_persona, calle, numero, piso, depto, id_barrio) VALUES (2,2,'Sarmiento', 179, NULL, NULL, 1);
INSERT INTO direccion(id_direccion, id_persona, calle, numero, piso, depto, id_barrio) VALUES (3,3,'Peron', 659, NULL, NULL, 1);
INSERT INTO direccion(id_direccion, id_persona, calle, numero, piso, depto, id_barrio) VALUES (4,4,'Alsina', 379, NULL, NULL, 1);
INSERT INTO direccion(id_direccion, id_persona, calle, numero, piso, depto, id_barrio) VALUES (5,5,'Colon', 2379, NULL, NULL, 2);
INSERT INTO direccion(id_direccion, id_persona, calle, numero, piso, depto, id_barrio) VALUES (6,6,'Carmen', 2379, NULL, NULL, 2);
INSERT INTO direccion(id_direccion, id_persona, calle, numero, piso, depto, id_barrio) VALUES (7,7,'Roca', 2379, NULL, NULL, 2);
INSERT INTO direccion(id_direccion, id_persona, calle, numero, piso, depto, id_barrio) VALUES (8,8,'Roca', 2379, NULL, NULL, 1);

--CLIENTE
INSERT INTO cliente (id_cliente, saldo) VALUES  (1, 1000);
INSERT INTO cliente (id_cliente, saldo) VALUES  (2, 2000);
INSERT INTO cliente (id_cliente, saldo) VALUES  (3, 3000);
INSERT INTO cliente (id_cliente, saldo) VALUES  (4, 4000);
INSERT INTO cliente (id_cliente, saldo) VALUES  (5, 5000);
INSERT INTO cliente (id_cliente, saldo) VALUES  (6, 6000);

--CATEGORIA
INSERT INTO categoria (id_cat, nombre) VALUES (1,'Cat1');
INSERT INTO categoria (id_cat, nombre) VALUES (2,'Cat2');
INSERT INTO categoria (id_cat, nombre) VALUES (3,'Cat3');

--SERVICIO
INSERT INTO servicio (id_servicio, nombre, periodico, costo, intervalo, tipo_intervalo, activo, id_cat)
VALUES(301,'Serv1','0',100,5,'mes','0',1);

INSERT INTO servicio (id_servicio, nombre, periodico, costo, intervalo, tipo_intervalo, activo, id_cat)
VALUES(302,'Serv2','1',200,5,'mes','1',2);

INSERT INTO servicio (id_servicio, nombre, periodico, costo, intervalo, tipo_intervalo, activo, id_cat)
VALUES(303,'Serv3','1',300,2,'mes','1',2);

--EQUIPO
INSERT INTO equipo (id_equipo, nombre, mac, ip, ap, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
            VALUES (100,'Equipo100','0101','1.5','2.1',301,1,'Jan 01, 2010',NULL,'PPTP','DHCP');
INSERT INTO equipo (id_equipo, nombre, mac, ip, ap, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
            VALUES (101,'Equipo101','0101','1.6','2.1',301,2,'Jan 01, 2010',NULL,'PPPoE','DHCP');
INSERT INTO equipo (id_equipo, nombre, mac, ip, ap, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
            VALUES (102,'Equipo102','0101','1.7','2.1',303,1,'Jan 01, 2010','Jan 01, 2021','PPTP','DHCP');
INSERT INTO equipo (id_equipo, nombre, mac, ip, ap, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
            VALUES (103,'Equipo103','0101','1.8','2.1',303,6,'Jan 01, 2010',NULL,'PPPoE','DHCP');
INSERT INTO equipo (id_equipo, nombre, mac, ip, ap, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
            VALUES (104,'Equipo104','0101','1.9','2.1',302,4,'Jan 01, 2010','Jan 01, 2015','PPPoE','IP FIJA');
INSERT INTO equipo (id_equipo, nombre, mac, ip, ap, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
            VALUES (105,'Equipo105','0101','1.12','2.1',301,5,'Jan 01, 2010',NULL,'PPPoE','IP FIJA');
INSERT INTO equipo (id_equipo, nombre, mac, ip, ap, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
            VALUES (106,'Equipo106','0101','1.10','2.1',302,4,'Jan 01, 2011','Jan 01, 2015','PPPoE','IP FIJA');
INSERT INTO equipo (id_equipo, nombre, mac, ip, ap, id_servicio, id_cliente, fecha_alta, fecha_baja, tipo_conexion, tipo_asignacion)
            VALUES (107,'Equipo107','0101','1.11','2.1',303,4,'Jan 01, 2011','Jan 01, 2015','PPPoE','IP FIJA');

--MAIL
INSERT INTO mail (id_persona,mail,tipo)
VALUES
  (1,'diam.dictum.sapien@nisl.co.uk','EMPRESARIAL'),
  (2,'magna.sed@massalobortis.edu','EMPRESARIAL'),
  (3,'convallis@natoquepenatibus.org','PERSONAL'),
  (4,'dictum.phasellus@varius.co.uk','INSTITUCIONAL'),
  (5,'nec@portaelit.org','EMPRESARIAL'),
  (6,'suspendisse@est.edu','PERSONAL'),
  (7,'commodo@tincidunt.co.uk','INSTITUCIONAL'),
  (8,'mus.proin@donectempor.org','INSTITUCIONAL'),
  (9,'velit@non.com','PERSONAL'),
  (10,'at.libero@vulputatedui.org','INSTITUCIONAL');

--TELEFONO
INSERT INTO telefono (id_persona,carac,numero)
VALUES
  (1,40,32233232),
  (2,49,32233239),
  (3,15,32233246),
  (4,59,32233253),
  (5,58,32233260),
  (6,25,32233267),
  (7,20,32233274),
  (8,14,32233281),
  (9,19,32233288),
  (10,14,32233295);

--ROL
INSERT INTO rol (id_rol,nombre)
VALUES
  (1,'RECURSOS HUMANOS'),
  (2,'MANTENIMIENTO'),
  (3,'INSTALADOR'),
  (4,'LIMPIEZA'),
  (5,'PRESIDENTE'),
  (6,'COBRADOR'),
  (7,'GERENTE'),
  (8,'SUPERVISOR'),
  (9,'TECNICO'),
  (10,'INGENIERO');

--PERSONAL
INSERT INTO personal (id_personal,id_rol)
VALUES
  (8,1),
  (10,7),
  (2,4),
  (1,10),
  (3,3),
  (5,3),
  (4,2),
  (6,1),
  (9,9),
  (7,9);

--TURNO
INSERT INTO turno (id_turno, desde, hasta, dinero_inicio, dinero_fin, id_personal)
VALUES
  (10,'Feb 01, 2010',NULL,500,NULL,1),
  (20,'Feb 01, 2010','March 01, 2010',550,NULL,2),
  (30,'Feb 01, 2010','Feb 01, 2011',2000,NULL,3),
  (40,'Feb 01, 2010',NULL,800,NULL,4),
  (50,'Feb 01, 2010',NULL,400,NULL,1),
  (60,'Feb 01, 2010',NULL,450,NULL,2),
  (70,'Feb 01, 2010',NULL,400,NULL,1),
  (80,'Feb 01, 2010','Dec 01, 2010',700,NULL,1),
  (90,'Feb 01, 2010',NULL,500,NULL,1),
  (100,'Feb 01, 2010',NULL,500,NULL,6);

--TIPOCOMPROBANTE
INSERT INTO tipocomprobante (id_tcomp, nombre, tipo)
VALUES
    (1, 'Nombre', 'Factura'),
    (2, 'Nombre', 'Recibo'),
    (3, 'Nombre', 'Remito');

--COMPROBANTE
INSERT INTO comprobante (id_comp, id_tcomp, fecha, comentario, estado, fecha_vencimiento, id_turno, importe, id_cliente)
values
    (01,1,'Jan 20, 2021','Comentario',NULL,NULL,10,200,3),
    (02,1,'Mar 29, 2017','Comentario',NULL,NULL,80,500,3),
    (03,2,'Jan 01, 2010','Comentario',NULL,NULL,20,600,1),
    (04,3,'Jul 02, 2012','Comentario',NULL,NULL,10,200,5),
    (05,1,'Jul 02, 2018','Comentario',NULL,NULL,10,200,5),
    (06,1,'Jul 25, 2019','Comentario',NULL,NULL,10,200,2),
    (07,1,'Jul 30, 2012','Comentario',NULL,NULL,10,200,5),
    (08,1,'Jul 30, 2018','Comentario',NULL,NULL,10,650,1),
    (05,3,'Apr 01, 2013','Comentario',NULL,NULL,60,300,6);

--LINEACOMPROBANTE
INSERT INTO lineacomprobante (nro_linea, id_comp, id_tcomp, descripcion, cantidad, importe, id_servicio)
VALUES
    (999,01,1,'Descripcion',2,100,301),
    (1000,01,1,'Descripcion',2,100,301),
    (279,02,1,'Descripcion',1,500,303),
    (277,08,1,'Descripcion',1,350,303),
    (274,08,1,'Descripcion',1,300,303),
    (450,05,3,'Descripcion',1,300,303);







-----------------------------------------------*********************************************************---------------------------------------------

/*
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

*/