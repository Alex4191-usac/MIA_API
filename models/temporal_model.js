let db = require('../config');
let temp = {};

temp.createTemporal = function(callback){
    if(db){
        let query = 
       
	"CREATE TABLE csv_table("+
	"nombre_victima VARCHAR(255) NOT NULL,"+
    "apellido_victima VARCHAR(255) NOT NULL,"+
    "direccion_victima VARCHAR(255) NOT NULL,"+
    "fecha_primera_sospecha DATETIME NOT NULL,"+
    "fecha_confirmacion DATETIME NOT NULL,"+
    "fecha_muerte DATETIME NOT NULL,"+
    "estado_victima VARCHAR(255) NOT NULL ,"+
    "nombre_asociado VARCHAR(255) NOT NULL,"+
    "apellido_asociado VARCHAR(255) NOT NULL,"+
    "fecha_conocio DATETIME NOT NULL,"+
    "contacto_fisico VARCHAR(255) NOT NULL,"+
    "fecha_inicio_contacto DATETIME NOT NULL,"+
    "fecha_fin_contacto DATETIME NOT NULL,"+
    "nombre_hospital VARCHAR(255) NOT NULL,"+
    "direccion_hospital VARCHAR(255) NOT NULL,"+
    "ubicacion_victima VARCHAR(255) NOT NULL,"+
    "fecha_llegada DATETIME NOT NULL,"+
    "fecha_retiro DATETIME NOT NULL,"+
    "tratamiento VARCHAR(255) NOT NULL,"+
    "efectividad_tratamiento INT NOT NULL,"+
    "fecha_inicio_tratamiento DATETIME NOT NULL,"+
    "fecha_fin_tratamiento DATETIME NULL,"+
    "efectividad_victima INT NOT NULL);"


        db.query(query, function(error,result){
            if(error)console.log(error);
            callback(result);
        });
    }
}

temp.getDatatemp = function (callback) {
    if (db) {

            var query = "SELECT * FROM csv_table;";
            db.query(query, function (error, resultado) {
                    if (error) console.log(error);
                    callback(resultado);
            });
    }
}


temp.cargarTemporal = function (callback) {

    if (db) {
            var query1 = "SET GLOBAL local_infile = 1;"
            db.query(query1, function(error, resultado) {
                    if (error) {
                        console.log(error);
                    } else {
                    
                            var query =
                                    "LOAD DATA local INFILE '/home/alex4191/Downloads/GRAND_VIRUS_EPICENTER.csv' \n" +
                                    "into table csv_table \n" +
                                    "character set utf8 \n"+
                                    "fields terminated by ';' \n" +
                                    "lines terminated by '\n' \n" +
                                    "ignore 1 lines \n" +
                                    "(nombre_victima,apellido_victima, direccion_victima,fecha_primera_sospecha,fecha_confirmacion,fecha_muerte,estado_victima,nombre_asociado,apellido_asociado,fecha_conocio,contacto_fisico,"+
                                        "fecha_inicio_contacto,fecha_fin_contacto,nombre_hospital,direccion_hospital,ubicacion_victima,"+
                                        "fecha_llegada,fecha_retiro,tratamiento,efectividad_tratamiento,fecha_inicio_tratamiento,"+
                                        "fecha_fin_tratamiento,efectividad_victima);";
                            
                            db.query(query, function (error, resultado) {
                                    if (error) throw error;
                                    callback(resultado);
                            });
                    }
            });                
    }
}


temp.eliminarTemporal = function (callback) {
    if (db) {

            var query = "DELETE FROM csv_table;";
            db.query(query, function (error, resultado) {
                    if (error) console.log(error);
                    callback(resultado);
            });
    }
}
  

module.exports = temp;