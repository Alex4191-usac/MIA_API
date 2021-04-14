USE GVE;


/*SELECT @@sql_mode;
SET GLOBAL sql_mode = 'ERROR_FOR_DIVISION_BY_ZERO';*/


/*QUERYS DE LA PRACTICA*/

/*1. Mostrar el nombre del hospital,su dirección y el número de fallecidos por cada hospital registrado.*/

delimiter //
CREATE PROCEDURE  consulta1()
BEGIN
	SELECT hospital.nombre, hospital.direccion, count(hospital.codigo_sanitario)  as cantidad_muertos FROM hospital 
	inner Join paciente_hospital on paciente_hospital.codigo_sanitario=hospital.codigo_sanitario
	where paciente_hospital.fecha_muerte!='0000-00-00 00:00:00'  group by hospital.codigo_sanitario 
	order by cantidad_muertos DESC;
END; //

CALL consulta1();
/*2.Mostrar el nombre, apelllido de todas las victimas en ESTADO cuarentena
que presentaron una efectividad mayor a 5 en el tratamiento "Transfusiones de sangre"*/
/*6*/

delimiter //
CREATE PROCEDURE  consulta2()
BEGIN
	select  v.nombre_victima, v.apellido , e.tipo_estado, efectividad_tratamiento, t.tipo_tratamiento from paciente_tratamiento 
	inner join paciente_hospital p 
	on paciente_tratamiento.numero_paciente = p.numero_paciente inner join victima v on p.numero_victima = v.numero_victima
	inner join estado e on v.registro_estado = e.registro_estado inner join tratamiento t on 
	paciente_tratamiento.codigo_tratamiento = t.codigo_tratamiento 
	WHERE e.tipo_estado='En cuarentena' and paciente_tratamiento.efectividad_tratamiento>5 and t.tipo_tratamiento='Transfusiones de sangre';

END; //

/*3.Mostrar el nombre, apellido y direccion de las victimas fallecidas
con mas de 3 personas asociadas*/
delimiter //
CREATE PROCEDURE  consulta3()
	BEGIN
		select victima.nombre_victima,victima.apellido,victima.direccion_victima, count(victima.numero_victima) as cantidad_asociados  FROM victima 
		inner join asocio_victima a on
		a.numero_victima = victima.numero_victima WHERE victima.numero_victima in (select victima.numero_victima FROM paciente_hospital inner join victima
		on paciente_hospital.numero_victima = victima.numero_victima where paciente_hospital.fecha_muerte!='0000-00-00 00:00:00')
		group by victima.numero_victima having count(victima.numero_victima)>3 order by cantidad_asociados DESC;
END; //


/*4.Mostrar el nombre y apellido de todas las victimas en estado
"Sospecha que tuvieron contacto fisico de tipo "BESO" con mas de 2
de sus asociados"*/
delimiter //
CREATE PROCEDURE  consulta4()
	BEGIN
		SELECT v.nombre_victima, v.apellido, c.numero_asociacion, cf.tipo_concacto , count(v.numero_victima) as cantidad_asociada FROM contacto_socio_victima c
		join asocio_victima a on c.numero_asociacion= a.numero_asociacion
		join victima v on a.numero_victima = v.numero_victima join contacto_fisico cf on c.codigo_contacto = cf.codigo_contacto
		join estado e on v.registro_estado = e.registro_estado where e.tipo_estado='Sospecha' and cf.tipo_concacto='Beso' group by a.numero_victima
		having count(v.numero_victima)>2;
END; //




/*5.Top 5 de victimas que mas tratamientos se han aplicado 
del tratamiento es OXIGENO*/

delimiter //
CREATE PROCEDURE  consulta5()
	BEGIN
		SELECT  v.nombre_victima, v.apellido, SUM(p.codigo_tratamiento = 3) as cantidad
		FROM paciente_tratamiento p  join paciente_hospital on p.numero_paciente = paciente_hospital.numero_paciente join
		victima v on paciente_hospital.numero_victima = v.numero_victima group by v.numero_victima order by cantidad DESC
		LIMIT 5;
END; //


/*TODOS 1*/

/*6.Mostrar el nombre, apellido y la fecha de fallecimiento de todas
las victimas que se movieron por la direccion 1978 Delphine Well a los 
cuales se les aplico Manejo de la presion arterial como tratamiento*/


delimiter //
CREATE PROCEDURE  consulta6()
	BEGIN
		SELECT distinctrow v.nombre_victima, v.apellido, ph.fecha_muerte, u.direccion, tr.tipo_tratamiento from bitacora_victima b
		join paciente_hospital ph on ph.numero_paciente = b.numero_paciente
		join victima v on ph.numero_victima = v.numero_victima
		join ubicacion u on b.registro_ubicacion = u.registro_ubicacion 
		join paciente_tratamiento pt on pt.numero_paciente = ph.numero_paciente
		join tratamiento tr on pt.codigo_tratamiento = tr.codigo_tratamiento
		WHERE ph.fecha_muerte!='0000-00-00 00:00:00' AND  u.direccion='1987 Delphine Well' and tr.tipo_tratamiento='Manejo de la presion arterial';
END; //

select * from csv_table;





/*7.Mostrar nombre,apellido y direccion de las victimas que tienen menos
de 2 allegados a los cuales hayan estado en un hospital y que se le hayan
aplicado unicamente dos tratamientos*/

/*3*/


delimiter //
CREATE PROCEDURE  consulta7()
	BEGIN
		SELECT  v.nombre_victima, v.apellido,  count(p.codigo_tratamiento) as cantidad
		FROM paciente_tratamiento p  join paciente_hospital on p.numero_paciente = paciente_hospital.numero_paciente join
		victima v on paciente_hospital.numero_victima = v.numero_victima WHERE v.numero_victima IN (select victima.numero_victima FROM victima 
		inner join asocio_victima a on
		a.numero_victima = victima.numero_victima WHERE victima.numero_victima in (select victima.numero_victima FROM paciente_hospital inner join victima
		on paciente_hospital.numero_victima = victima.numero_victima) 
		group by victima.numero_victima having count(victima.numero_victima)<2 
		) group by v.numero_victima 
		having count(p.codigo_tratamiento)=2 order by cantidad;
END; //




/*CHANCELLOR ASO=1 Y CANTIDAD=2
TAMARA ASO=1 Y CANTIDAD=2*/


/*8.Mostrar el numero de mes, de la fecha de la primera sospecha, nombre
y apellido de las victimas que mas tratamientos se han aplicado y las que
menos ( Todo en una sola consulta)*/

delimiter //
CREATE PROCEDURE  consulta8()
	BEGIN
		(SELECT  v.nombre_victima, v.apellido, month(v.fecha_primera_sospecha) as mes, count(p.codigo_tratamiento) as cantidad
		FROM paciente_tratamiento p  join paciente_hospital on p.numero_paciente = paciente_hospital.numero_paciente join
		victima v on paciente_hospital.numero_victima = v.numero_victima group by v.numero_victima having count(cantidad) = 
        (select MAX(cnt) FROM (SELECT  vs.nombre_victima, vs.apellido, month(vs.fecha_primera_sospecha) as mesesito, count(ps.codigo_tratamiento) as cnt
		FROM paciente_tratamiento ps  join paciente_hospital on ps.numero_paciente = paciente_hospital.numero_paciente join
		victima vs on paciente_hospital.numero_victima = vs.numero_victima group by vs.numero_victima) rc))
		UNION ALL
		(SELECT  v.nombre_victima, v.apellido, month(v.fecha_primera_sospecha) as mes, count(p.codigo_tratamiento) as cantidad
		FROM paciente_tratamiento p  join paciente_hospital on p.numero_paciente = paciente_hospital.numero_paciente join
		victima v on paciente_hospital.numero_victima = v.numero_victima group by v.numero_victima having count(cantidad) = 
        (select MIN(cnt) FROM (SELECT  vs.nombre_victima, vs.apellido, month(vs.fecha_primera_sospecha) as mesesito, count(ps.codigo_tratamiento) as cnt
		FROM paciente_tratamiento ps  join paciente_hospital on ps.numero_paciente = paciente_hospital.numero_paciente join
		victima vs on paciente_hospital.numero_victima = vs.numero_victima group by vs.numero_victima) mc));
END; //





/*9.Mostrar el porcentaje de victimas que le corresponden a cada hospital*/

delimiter //
CREATE PROCEDURE  consulta9()
	BEGIN
		SELECT hospital.codigo_sanitario, hospital.nombre,
		COUNT(paciente_hospital.codigo_sanitario) AS Total ,
		(COUNT(paciente_hospital.codigo_sanitario) / (SELECT COUNT(*) FROM paciente_hospital)) * 100 AS Percentage
		FROM paciente_hospital inner join hospital on paciente_hospital.codigo_sanitario=hospital.codigo_sanitario group by hospital.codigo_sanitario
		order by Percentage DESC;
END; //













/*10. Mostrar el porcentaje del contacto fisico mas comun de cada hospital
de la siguiente manera: nombre de hospital, nombre del contacto fisico, 
porcentaje de victimas*/
SELECT v.nombre_victima, v.apellido,a.nombre,h.nombre,c.tipo_concacto FROM paciente_hospital ph
inner join hospital h on ph.codigo_sanitario = h.codigo_sanitario
inner join victima v on ph.numero_victima = v.numero_victima
inner join asocio_victima av on v.numero_victima = av.numero_victima
inner join asociado a on av.numero_asociado = a.numero_asociado
inner join contacto_socio_victima csv on av.numero_asociacion = csv.numero_asociacion
inner join contacto_fisico c on csv.codigo_contacto = c.codigo_contacto;


delimiter //
CREATE PROCEDURE  consulta10()
	BEGIN
		SELECT G.NHospital AS Nombre_Hospital,G.tipo_concacto AS Tipo_Contacto,H.Porcentaje AS Porcentajes FROM
(SELECT DISTINCT T.NHospital,T.UHospital,T.tipo_concacto,SUM(T.Total) AS Suma FROM
(SELECT DISTINCT victima.nombre_victima,victima.apellido,victima.direccion_victima,victima.fecha_primera_sospecha,
hospital.nombre AS NHospital,hospital.direccion AS UHospital,
contacto_fisico.tipo_concacto,COUNT(contacto_fisico.tipo_concacto) AS Total 
FROM victima
INNER JOIN asocio_victima ON asocio_victima.numero_victima = victima.numero_victima
INNER JOIN contacto_socio_victima ON contacto_socio_victima.numero_asociacion = asocio_victima.numero_asociacion
INNER JOIN contacto_fisico ON contacto_fisico.codigo_contacto = contacto_socio_victima.codigo_contacto
INNER JOIN paciente_hospital ON paciente_hospital.numero_victima = victima.numero_victima
INNER JOIN hospital ON hospital.codigo_sanitario = paciente_hospital.codigo_sanitario
GROUP BY victima.nombre_victima,victima.apellido,victima.direccion_victima,
victima.fecha_primera_sospecha,
paciente_hospital.fecha_confirmacion, paciente_hospital.fecha_muerte,
hospital.nombre,hospital.direccion,contacto_fisico.tipo_concacto) AS T
GROUP BY T.NHospital,T.UHospital,T.tipo_concacto) AS G,
(SELECT DISTINCT F.NHospital,F.UHospital,F.tipo_concacto,MAX(F.Suma) AS Maximo,((MAX(F.Suma)/SUM(F.Suma))*100) AS Porcentaje FROM
(SELECT DISTINCT T.NHospital,T.UHospital,T.tipo_concacto,SUM(T.Total) AS Suma FROM 
(SELECT victima.nombre_victima,victima.apellido,victima.direccion_victima,victima.fecha_primera_sospecha,
hospital.nombre AS NHospital,hospital.direccion AS UHospital,
contacto_fisico.tipo_concacto,COUNT(contacto_fisico.tipo_concacto) AS Total 
FROM victima
INNER JOIN asocio_victima ON asocio_victima.numero_victima = victima.numero_victima
INNER JOIN contacto_socio_victima ON contacto_socio_victima.numero_asociacion = asocio_victima.numero_asociacion
INNER JOIN contacto_fisico ON contacto_fisico.codigo_contacto = contacto_socio_victima.codigo_contacto
INNER JOIN paciente_hospital ON paciente_hospital.numero_victima = victima.numero_victima
INNER JOIN hospital ON hospital.codigo_sanitario = paciente_hospital.codigo_sanitario
GROUP BY victima.nombre_victima,victima.apellido,victima.direccion_victima,
victima.fecha_primera_sospecha,
paciente_hospital.fecha_confirmacion, paciente_hospital.fecha_muerte,
hospital.nombre,hospital.direccion,contacto_fisico.tipo_concacto) AS T
GROUP BY T.NHospital,T.UHospital,T.tipo_concacto)  AS F
GROUP BY F.NHospital,F.UHospital) AS H
WHERE G.NHospital = H.NHospital AND G.UHospital = H.UHospital AND G.Suma = H.Maximo;

END; //




/*San juan 90% Beso*/
SELECT * FROM hospital; /*80*/
SELECT * FROM tratamiento; /*5*/
SELECT * FROM ubicacion; /*120*/
SELECT * FROM estado; /*14*/
SELECT * FROM contacto_fisico; /*8*/
SELECT * FROM victima; /*1000*/
SELECT * FROM paciente_hospital;/*688*/
SELECT * FROM asocio_victima; /*4525*/
SELECT * FROM contacto_socio_victima;/*7282*/
SELECT * FROM bitacora_victima; /*6299*/
SELECT v.nombre_victima, v.apellido FROM paciente_tratamiento
join paciente_hospital p on paciente_tratamiento.numero_paciente=p.numero_paciente
join victima v on p.numero_victima =v.numero_victima;/*636*/

SELECT * FROM hospital;
SELECt * FROM csv_table;
