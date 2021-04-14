var database = require('../config');
var consulta = {};


//CONSULTA 1
consulta.consulta1 = function (callback) {
    if (database) {

            var query ="CALL consulta1";

            database.query(query, function (error, result) {
                    if (error) console.log(error);
                    callback(result);
            });
    }
}

//CONSULTA 2
consulta.consulta2 = function (callback) {
    if (database) {

            var query ="CALL consulta2";

            database.query(query, function (error, result) {
                    if (error) console.log(error);
                    callback(result);
            });
    }
}

//CONSULTA 3
consulta.consulta3 = function (callback) {
    if (database) {

            var query ="CALL consulta3";

            database.query(query, function (error, result) {
                    if (error) console.log(error);
                    callback(result);
            });
    }
}

//CONSULTA 4
consulta.consulta4 = function (callback) {
        if (database) {
    
                var query ="CALL consulta4";
    
                database.query(query, function (error, result) {
                        if (error) console.log(error);
                        callback(result);
                });
        }
    }

//CONSULTA 5
consulta.consulta5 = function (callback) {
        if (database) {
    
                var query ="CALL consulta5";
    
                database.query(query, function (error, result) {
                        if (error) console.log(error);
                        callback(result);
                });
        }
    }
//CONSULTA 6
consulta.consulta6 = function (callback) {
        if (database) {
    
                var query ="CALL consulta6";
    
                database.query(query, function (error, result) {
                        if (error) console.log(error);
                        callback(result);
                });
        }
    }



//CONSULTA 7
consulta.consulta7 = function (callback) {
        if (database) {
    
                var query ="CALL consulta7";
    
                database.query(query, function (error, result) {
                        if (error) console.log(error);
                        callback(result);
                });
        }
    }

//CONSULTA 8
consulta.consulta8 = function (callback) {
        if (database) {
    
                var query ="CALL consulta8";
    
                database.query(query, function (error, result) {
                        if (error) console.log(error);
                        callback(result);
                });
        }
    }


//CONSULTA 8
consulta.consulta9 = function (callback) {
        if (database) {
    
                var query ="CALL consulta9";
    
                database.query(query, function (error, result) {
                        if (error) console.log(error);
                        callback(result);
                });
        }
    }


//CONSULTA 8
consulta.consulta10 = function (callback) {
        if (database) {
    
                var query ="CALL consulta10";
    
                database.query(query, function (error, result) {
                        if (error) console.log(error);
                        callback(result);
                });
        }
    }




//load data
consulta.cargarModelo = function (callback) {
        if (database) {
    
                var query ="CALL crear_modelo;";
    
                database.query(query, function (error, result) {
                        if (error) console.log(error);
                        callback(result);
                });
        }
}


consulta.eliminarModelo = function (callback) {
        if (database) {
    
                var query ="CALL eliminar_modelo();";
    
                database.query(query, function (error, result) {
                        if (error) console.log(error);
                        callback(result);
                });
        }
}



module.exports = consulta;
/*CALL insert_estado();
CALL insert_tratamiento();
CALL insert_ubicacion();
CALL insert_contacto();
CALL insert_hospital();
CALL insert_asociado();

CALL insert_victima();
CALL insert_paciente_hospital();
CALL insert_asocio_victima();
CALL insert_contacto_socio_victima();
CALL insert_bitacora_victima();
CALL insert_paciente_tratamiento(); */