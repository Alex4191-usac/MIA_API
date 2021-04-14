/*BULK'S QUERY*/

/*LOCATION OF CSV FILE=/home/alex4191/Downloads/GRAND_VIRUS_EPICENTER.csv*/
USE GVE;

SET GLOBAL local_infile = 1;
LOAD DATA local INFILE '/home/alex4191/Downloads/GRAND_VIRUS_EPICENTER.csv'
into table csv_table
character set utf8
fields terminated by ';'
lines terminated by '\n'
ignore 1 lines
(nombre_victima,apellido_victima, direccion_victima,fecha_primera_sospecha,fecha_confirmacion,fecha_muerte,estado_victima,nombre_asociado,apellido_asociado,fecha_conocio,contacto_fisico,
fecha_inicio_contacto,fecha_fin_contacto,nombre_hospital,direccion_hospital,ubicacion_victima,
fecha_llegada,fecha_retiro,tratamiento,efectividad_tratamiento,fecha_inicio_tratamiento,
fecha_fin_tratamiento,efectividad_victima);
/*set fecha_primera_sospecha = CAST(@fecha_p AS date);
*/
select * from hospital;
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


select * from contacto_socio_victima;



