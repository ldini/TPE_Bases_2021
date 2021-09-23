-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-09-22 21:53:49.256

-- foreign keys
ALTER TABLE LineaComprobante
    DROP CONSTRAINT LineaComprobante_Servicio;

ALTER TABLE Barrio
    DROP CONSTRAINT fk_barrio_ciudad;

ALTER TABLE Cliente
    DROP CONSTRAINT fk_cliente_persona;

ALTER TABLE Comprobante
    DROP CONSTRAINT fk_comprobante_cliente;

ALTER TABLE Comprobante
    DROP CONSTRAINT fk_comprobante_tipocomprobante;

ALTER TABLE Comprobante
    DROP CONSTRAINT fk_comprobante_turno;

ALTER TABLE Direccion
    DROP CONSTRAINT fk_direccion;

ALTER TABLE Direccion
    DROP CONSTRAINT fk_direccion_barrio;

ALTER TABLE Equipo
    DROP CONSTRAINT fk_equipo_cliente;

ALTER TABLE Equipo
    DROP CONSTRAINT fk_equipo_servicio;

ALTER TABLE LineaComprobante
    DROP CONSTRAINT fk_lineacomprobante_comprobante;

ALTER TABLE Mail
    DROP CONSTRAINT fk_mail_persona;

ALTER TABLE Personal
    DROP CONSTRAINT fk_personal_persona;

ALTER TABLE Personal
    DROP CONSTRAINT fk_personal_rol;

ALTER TABLE Turno
    DROP CONSTRAINT fk_personal_turno;

ALTER TABLE Servicio
    DROP CONSTRAINT fk_servicio_categoria;

ALTER TABLE Telefono
    DROP CONSTRAINT fk_telefono;

-- tables
DROP TABLE Barrio;

DROP TABLE Categoria;

DROP TABLE Ciudad;

DROP TABLE Cliente;

DROP TABLE Comprobante;

DROP TABLE Direccion;

DROP TABLE Equipo;

DROP TABLE LineaComprobante;

DROP TABLE Mail;

DROP TABLE Persona;

DROP TABLE Personal;

DROP TABLE Rol;

DROP TABLE Servicio;

DROP TABLE Telefono;

DROP TABLE TipoComprobante;

DROP TABLE Turno;

-- End of file.

