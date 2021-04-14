/*DATABASE SCRIPT CREATED BY ALEX4191*/
/*ALTER USER 'Alex4191'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Alex!41916722';
flush privileges;*/

CREATE DATABASE IF NOT EXISTS GVE;

USE GVE;

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
    REFERENCES asociado(numero_asociado),
    CONSTRAINT fk_numero_victima FOREIGN KEY (numero_victima) 
    REFERENCES victima(numero_victima)
);

CREATE TABLE IF NOT EXISTS contacto_socio_victima(
	numero_asociacion INT,
    codigo_contacto INT,
    fecha_inicio_contacto DATETIME NULL,
    fecha_fin_contacto DATETIME NULL,
    CONSTRAINT fk_numero_asociacion FOREIGN KEY (numero_asociacion)
    REFERENCES asocio_victima(numero_asociacion),
	CONSTRAINT fk_codigo_contacto FOREIGN KEY (codigo_contacto)
    REFERENCES contacto_fisico(codigo_contacto)
);

CREATE TABLE IF NOT EXISTS paciente_hospital(
	 numero_paciente INT AUTO_INCREMENT,
     numero_victima INT,
     codigo_sanitario INT,
     fecha_confirmacion DATETIME NULL,
     fecha_muerte DATETIME NULL,
     PRIMARY KEY (numero_paciente),
     CONSTRAINT fk_numero_paciente FOREIGN KEY (numero_victima)
     REFERENCES victima(numero_victima),
     CONSTRAINT fk_codigo_sanitario FOREIGN KEY (codigo_sanitario)
     REFERENCES hospital(codigo_sanitario)
);

CREATE TABLE IF NOT EXISTS paciente_tratamiento(
	numero_paciente INT,
    codigo_tratamiento INT,
    fecha_inicio_tratamiento DATETIME NOT NULL,
	fecha_fin_tratamiento DATETIME NOT NULL,
    efectividad_tratamiento INT NOT NULL,
    CONSTRAINT fk_codigo_tratamiento FOREIGN KEY (codigo_tratamiento)
    REFERENCES tratamiento(codigo_tratamiento),
    CONSTRAINT fk_paciente FOREIGN KEY (numero_paciente)
    REFERENCES paciente_hospital(numero_paciente)
);

CREATE TABLE IF NOT EXISTS bitacora_victima(
	bitacora int AUTO_INCREMENT, 
    numero_paciente INT,
    registro_ubicacion INT,
    fecha_llegada DATETIME NULL,
    fecha_salida DATETIME NULL,
    PRIMARY KEY (bitacora),
    CONSTRAINT fk_numero_paciente_bv FOREIGN KEY (numero_paciente) 
    REFERENCES paciente_hospital(numero_paciente),
    CONSTRAINT fk_ubicacion FOREIGN KEY (registro_ubicacion)
    REFERENCES ubicacion(registro_ubicacion)
);

/*TEMPORARY TABLE*/


CREATE TABLE csv_table(
	nombre_victima VARCHAR(255) NOT NULL,
    apellido_victima VARCHAR(255) NOT NULL,
    direccion_victima VARCHAR(255) NOT NULL,
    fecha_primera_sospecha DATETIME NOT NULL,
    fecha_confirmacion DATETIME NOT NULL,
    fecha_muerte DATETIME NOT NULL,
    estado_victima VARCHAR(255) NOT NULL ,
    nombre_asociado VARCHAR(255) NOT NULL,
    apellido_asociado VARCHAR(255) NOT NULL,
    fecha_conocio DATETIME NOT NULL,
    contacto_fisico VARCHAR(255) NOT NULL,
    fecha_inicio_contacto DATETIME NOT NULL,
    fecha_fin_contacto DATETIME NOT NULL,
    nombre_hospital VARCHAR(255) NOT NULL,
    direccion_hospital VARCHAR(255) NOT NULL,
    ubicacion_victima VARCHAR(255) NOT NULL,
    fecha_llegada DATETIME NOT NULL,
    fecha_retiro DATETIME NOT NULL,
    tratamiento VARCHAR(255) NOT NULL,
    efectividad_tratamiento INT NOT NULL,
    fecha_inicio_tratamiento DATETIME NOT NULL,
    fecha_fin_tratamiento DATETIME NULL,
    efectividad_victima INT NOT NULL
);


