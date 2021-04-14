let express = require('express');
let temporal = require('../models/temporal_model');
let tempoRouter = express.Router();


tempoRouter.get('/crearTemporal', function (req, res) {

    temporal.createTemporal(function (result) {
      if (typeof result !== undefined) {
  
        res.json(result)
      } else {
        res.json({ "mensaje": "No se pudo crear la tabla" });
      }
    });
  });


//  GET
tempoRouter.get('/getDatatemp', function (req, res) {

    temporal.getDatatemp(function (result) {
      if (typeof result !== undefined) {
  
  
        res.json(result);
  
      } else {
        res.json({ "mensaje": "No se pudo crear la tabla" });
      }
    });
  });

////  POST
tempoRouter.get('/cargarTemporal', function (req, res) {

    temporal.cargarTemporal(function (result) {
      if (typeof result !== undefined) {
  
  
      
        res.json(result)
      } else {
        res.json({ "mensaje": "No se pudo crear la tabla" });
      }
    });
  });


// DELETE
tempoRouter.get('/eliminarTemporal', function (req, res) {

    temporal.eliminarTemporal(function (result) {
      if (typeof result !== undefined) {
  
        res.json(result);
  
      } else {
        res.json({ "mensaje": "No se pudo eliminar la tabla" });
      }
    });
  });



module.exports = tempoRouter;