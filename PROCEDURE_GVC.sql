/*PROCEDURES*/

USE GVE;

delimiter //
CREATE PROCEDURE  insert_estado()
BEGIN
	INSERT INTO estado(tipo_estado)
	SELECT distinct 
		estado_victima 
	FROM csv_table WHERE estado_victima!="";
END; //

delimiter //
CREATE PROCEDURE insert_tratamiento()
BEGIN
	INSERT INTO tratamiento(tipo_tratamiento,efectividad)
	SELECT distinct 
		tratamiento,efectividad_tratamiento
	FROM csv_table  WHERE tratamiento!="";
END; //

delimiter //
CREATE PROCEDURE insert_ubicacion()
BEGIN
	INSERT INTO ubicacion(direccion)
	SELECT distinct 
		ubicacion_victima 
	FROM csv_table WHERE ubicacion_victima!="";
END; //

delimiter //
CREATE PROCEDURE insert_contacto()
BEGIN
	INSERT INTO contacto_fisico(tipo_concacto)
	SELECT distinct 
		contacto_fisico 
	FROM csv_table WHERE contacto_fisico!="";
END; //


delimiter //
CREATE PROCEDURE insert_hospital()
BEGIN
INSERT INTO hospital(nombre,direccion)
	SELECT distinct 
		nombre_hospital,direccion_hospital
	FROM csv_table WHERE nombre_hospital!="" and direccion_hospital!=""
	GROUP BY nombre_hospital;  
END; //

delimiter //
CREATE PROCEDURE insert_asociado()
BEGIN
	INSERT INTO asociado(nombre,apellido)
	SELECT distinct 
		nombre_asociado,apellido_asociado
	FROM csv_table WHERE (nombre_asociado!="" AND apellido_asociado!="");
END; //

delimiter //
CREATE PROCEDURE insert_victima()
BEGIN
	INSERT INTO victima(nombre_victima,apellido,direccion_victima,fecha_primera_sospecha,registro_estado)
    SELECT distinct
		T.nombre_victima, T.apellido_victima, T.direccion_victima, T.fecha_primera_sospecha,(SELECT registro_estado FROM estado WHERE tipo_estado = T.estado_victima)
        FROM csv_table AS T WHERE fecha_primera_sospecha!='0000-00-00 00:00:00';
END;//


delimiter //
CREATE PROCEDURE insert_paciente_hospital()
BEGIN
	INSERT INTO paciente_hospital (numero_victima,codigo_sanitario,fecha_confirmacion,fecha_muerte)
	SELECT distinct victima.numero_victima, hospital.codigo_sanitario,T.fecha_confirmacion,
    T.fecha_muerte FROM csv_table T
    INNER JOIN hospital ON T.nombre_hospital = hospital.nombre/* AND T.direccion_hospital = hospital.direccion AGREGADO LA DIRECCION POR PROBLEMA DE LINK CON NOMBRES
    Y DIRECCIONES QUE NO ESTAN EN HOSPITAL PERO SI EN LA TEMPORAL*/
    INNER JOIN victima ON T.nombre_victima = victima.nombre_victima AND T.apellido_victima=victima.apellido;
END;//


delimiter //
CREATE PROCEDURE insert_asocio_victima()
BEGIN
INSERT INTO asocio_victima(fecha_conocio,numero_asociado,numero_victima)
SELECT distinct T.fecha_conocio, a.numero_asociado ,v.numero_victima FROM csv_table T
INNER JOIN victima v ON T.nombre_victima = v.nombre_victima and T.apellido_victima = v.apellido
INNER JOIN asociado a ON T.nombre_asociado = a.nombre and T.apellido_asociado = a.apellido;
END;//




delimiter //
CREATE PROCEDURE insert_contacto_socio_victima()
BEGIN
	INSERT INTO contacto_socio_victima (numero_asociacion, codigo_contacto, fecha_inicio_contacto, fecha_fin_contacto)
    SELECT distinct  a.numero_asociacion ,c.codigo_contacto,T.fecha_inicio_contacto,T.fecha_fin_contacto FROM csv_table T
	INNER JOIN contacto_fisico c ON T.contacto_fisico = c.tipo_concacto
	INNER JOIN asocio_victima a ON T.fecha_conocio = a.fecha_conocio;
END;//

delimiter //
CREATE PROCEDURE insert_bitacora_victima()
BEGIN
INSERT INTO bitacora_victima(numero_paciente,registro_ubicacion,fecha_llegada,fecha_salida)
SELECT distinct h.numero_paciente, d.registro_ubicacion, T.fecha_llegada, T.fecha_retiro FROM csv_table T
 INNER JOIN paciente_hospital h on T.fecha_confirmacion = h.fecha_confirmacion AND T.fecha_muerte = h.fecha_muerte
 INNER JOIN ubicacion d on T.ubicacion_victima = d.direccion AND T.fecha_llegada!='0000-00-00';
END;//


delimiter //
CREATE PROCEDURE insert_paciente_tratamiento()
BEGIN
	INSERT INTO paciente_tratamiento (numero_paciente,codigo_tratamiento, fecha_inicio_tratamiento, fecha_fin_tratamiento,efectividad_tratamiento)
	SELECT DISTINCT  h.numero_paciente, tr.codigo_tratamiento, T.fecha_inicio_tratamiento,T.fecha_fin_tratamiento, T.efectividad_victima  
    FROM csv_table T INNER JOIN tratamiento tr on (T.tratamiento!="" AND T.tratamiento =tr.tipo_tratamiento)
    AND (T.efectividad_tratamiento!="" AND T.efectividad_tratamiento = tr.efectividad)
    INNER JOIN paciente_hospital h ON (T.fecha_confirmacion!='0000-00-00 00:00:00' AND
     h.fecha_confirmacion=T.fecha_confirmacion) AND
     h.fecha_muerte=T.fecha_muerte  AND h.numero_victima=(SELECT distinct v.numero_victima
    FROM victima v WHERE v.nombre_victima = T.nombre_victima AND v.apellido = T.apellido_victima
    AND v.direccion_victima = T.direccion_victima);
END;//

delimiter //
CREATE PROCEDURE crear_modelo()
BEGIN
CREATE TABLE IF NOT EXISTS estado(
	registro_estado INT AUTO_INCREMENT,
    tipo_estado VARCHAR(255) NOT NULL,
    PRIMARY KEY (registro_estado)
);

CREATE TABLE IF NOT EXISTS tratamiento(
	codigo_tratamiento INT AUTO_INCREMENT,
    tipo_tratamiento VARCHAR(255) NOT NULL,
    efectividad INT NOT NULL,
    PRIMARY KEY (codigo_tratamiento)
);

CREATE TABLE IF NOT EXISTS ubicacion(
	registro_ubicacion INT AUTO_INCREMENT,
	direccion VARCHAR(255) NOT NULL,
    PRIMARY KEY (registro_ubicacion)
);

CREATE TABLE IF NOT EXISTS contacto_fisico(
	codigo_contacto INT AUTO_INCREMENT,
    tipo_concacto VARCHAR(255) NOT NULL,
    PRIMARY KEY (codigo_contacto)
);

CREATE TABLE IF NOT EXISTS hospital(
	codigo_sanitario INT AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    PRIMARY KEY (codigo_sanitario)
);

CREATE TABLE IF NOT EXISTS asociado(
	numero_asociado INT AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    PRIMARY KEY (numero_asociado)
);

CREATE TABLE IF NOT EXISTS victima(
	numero_victima INT AUTO_INCREMENT,
    nombre_victima VARCHAR(255) NOT NULL,
    apellido VARCHAR (255) NOT NULL,
    direccion_victima VARCHAR (255) NOT NULL,
    fecha_primera_sospecha DATETIME NOT NULL ,
    registro_estado INT,
    PRIMARY KEY (numero_victima) ,
    CONSTRAINT fk_estado FOREIGN KEY (registro_estado)
    REFERENCES estado(registro_estado) ON DELETE CASCADE  
);

CREATE TABLE IF NOT EXISTS asocio_victima(
	numero_asociacion INT AUTO_INCREMENT,
    fecha_conocio DATETIME NOT NULL,
    numero_asociado INT,
    numero_victima INT,
    PRIMARY KEY (numero_asociacion) ,
    CONSTRAINT fk_numero_asociado FOREIGN KEY (numero_asociado)
    REFERENCES asociado(numero_asociado) ON DELETE CASCADE,
    CONSTRAINT fk_numero_victima FOREIGN KEY (numero_victima) 
    REFERENCES victima(numero_victima) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS contacto_socio_victima(
	numero_asociacion INT,
    codigo_contacto INT,
    fecha_inicio_contacto DATETIME NULL,
    fecha_fin_contacto DATETIME NULL,
    CONSTRAINT fk_numero_asociacion FOREIGN KEY (numero_asociacion)
    REFERENCES asocio_victima(numero_asociacion) ON DELETE CASCADE,
	CONSTRAINT fk_codigo_contacto FOREIGN KEY (codigo_contacto)
    REFERENCES contacto_fisico(codigo_contacto) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS paciente_hospital(
	 numero_paciente INT AUTO_INCREMENT,
     numero_victima INT,
     codigo_sanitario INT,
     fecha_confirmacion DATETIME NULL,
     fecha_muerte DATETIME NULL,
     PRIMARY KEY (numero_paciente),
     CONSTRAINT fk_numero_paciente FOREIGN KEY (numero_victima)
     REFERENCES victima(numero_victima) ON DELETE CASCADE,
     CONSTRAINT fk_codigo_sanitario FOREIGN KEY (codigo_sanitario)
     REFERENCES hospital(codigo_sanitario) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS paciente_tratamiento(
	numero_paciente INT,
    codigo_tratamiento INT,
    fecha_inicio_tratamiento DATETIME NOT NULL,
	fecha_fin_tratamiento DATETIME NOT NULL,
    efectividad_tratamiento INT NOT NULL,
    CONSTRAINT fk_codigo_tratamiento FOREIGN KEY (codigo_tratamiento)
    REFERENCES tratamiento(codigo_tratamiento) ON DELETE CASCADE,
    CONSTRAINT fk_paciente FOREIGN KEY (numero_paciente)
    REFERENCES paciente_hospital(numero_paciente) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS bitacora_victima(
	bitacora int AUTO_INCREMENT, 
    numero_paciente INT,
    registro_ubicacion INT,
    fecha_llegada DATETIME NULL,
    fecha_salida DATETIME NULL,
    PRIMARY KEY (bitacora),
    CONSTRAINT fk_numero_paciente_bv FOREIGN KEY (numero_paciente) 
    REFERENCES paciente_hospital(numero_paciente) ON DELETE CASCADE,
    CONSTRAINT fk_ubicacion FOREIGN KEY (registro_ubicacion)
    REFERENCES ubicacion(registro_ubicacion) ON DELETE CASCADE
);
CALL insert_estado();
CALL insert_tratamiento();
CALL insert_ubicacion();
CALL insert_contacto();
CALL insert_hospital();
CALL insert_asociado();
/*WITH FK KEYS*/
CALL insert_victima();
CALL insert_paciente_hospital();
CALL insert_asocio_victima();
CALL insert_contacto_socio_victima();
CALL insert_bitacora_victima();
CALL insert_paciente_tratamiento();
END;//

delimiter //
CREATE PROCEDURE eliminar_modelo()
BEGIN
     DROP TABLE contacto_socio_victima;
     DROP TABLE paciente_tratamiento;
     DROP TABLE bitacora_victima;
     DROP TABLE paciente_hospital;
     DROP TABLE asocio_victima;
     DROP TABLE asociado;
     DROP TABLE contacto_fisico;
     DROP TABLE tratamiento;
     DROP TABLE ubicacion;
     DROP TABLE hospital;
     DROP TABLE victima;
     DROP TABLE estado;
     
END;//


CALL eliminar_modelo();
                
