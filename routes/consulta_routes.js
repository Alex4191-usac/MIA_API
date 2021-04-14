let express = require('express');
let consulta = require('../models/consulta_model');
let consultaRouter = express.Router();


// CONSULTA 1
consultaRouter.get('/consulta1', function (req, res) {

    consulta.consulta1(function (result) {
      if (typeof result !== undefined) {
  
        res.json(result);
  
      } else {
        res.json({ "mensaje": "No se pudo ejecutar la consulta1" });
      }
    });
  });
  
  // CONSULTA 2
  consultaRouter.get('/consulta2', function (req, res) {
  
    consulta.consulta2(function (result) {
      if (typeof result !== undefined) {
  
        res.json(result);
  
      } else {
        res.json({ "mensaje": "No se pudo ejecutar la consulta2" });
      }
    });
  });
  
 
  // CONSULTA 3
  consultaRouter.get('/consulta3', function (req, res) {
  
    consulta.consulta3(function (result) {
      if (typeof result !== undefined) {
        res.json(result[0]);
  
      } else {
        res.json({ "mensaje": "No se pudo ejecutar la consulta3" });
      }
    });
  });
  
  
  
  
  // CONSULTA 4
  consultaRouter.get('/consulta4', function (req, res) {
  
    consulta.consulta4(function (result) {
      if (typeof result !== undefined) {
        res.json(result[0]);
  
      } else {
        res.json({ "mensaje": "No se pudo ejecutar la consulta4" });
      }
    });
  });
  
  
  
  // CONSULTA 4
  consultaRouter.get('/consulta5', function (req, res) {
  
    consulta.consulta5(function (result) {
      if (typeof result !== undefined) {
        res.json(result[0]);
  
      } else {
        res.json({ "mensaje":"No se pudo ejecutar la consulta5" });
      }
    });
  });
  
  
  
  // CONSULTA 6
  consultaRouter.get('/consulta6', function (req, res) {
  
    consulta.consulta6(function (result) {
      if (typeof result !== undefined) {
        res.json(result[0]);
  
      } else {
        res.json({ "mensaje": "No se pudo ejecutar la consulta6" });
      }
    });
  });
  
  
  
  
  // CONSULTA 7
  consultaRouter.get('/consulta7', function (req, res) {
  
    consulta.consulta7(function (result) {
      if (typeof result !== undefined) {
        res.json(result[0]);
  
      } else {
        res.json({ "mensaje": "No se pudo ejecutar la consulta7" });
      }
    });
  });
  
  // CONSULTA 8
  consultaRouter.get('/consulta8', function (req, res) {
  
    consulta.consulta8(function (result) {
      if (typeof result !== undefined) {
        res.json(result[0]);
  
      } else {
        res.json({ "mensaje": "No se pudo ejecutar la consulta8" });
      }
    });
  });
  

  
  // CONSULTA 7
  consultaRouter.get('/consulta9', function (req, res) {
  
    consulta.consulta9(function (result) {
      if (typeof result !== undefined) {
        res.json(result[0]);
  
      } else {
        res.json({ "mensaje": "No se pudo realizar la consulta 9" });
      }
    });
  });
  
  
  
  
  // CONSULTA 10
  consultaRouter.get('/consulta10', function (req, res) {
  
    consulta.consulta10(function (result) {
      if (typeof result !== undefined) {
        res.json(result[0]);
  
      } else {
        res.json({ "mensaje": "No se pudo realizar la consulta10" });
      }
    });
  });




   // CONSULTA 11
   consultaRouter.get('/cargarModelo', function (req, res) {
  
    consulta.cargarModelo(function (result) {
      if (typeof result !== undefined) {
        res.json(result[0]);
  
      } else {
        res.json({ "mensaje": "No se pudo cargar el Modelo" });
      }
    });
  });
  




   // CONSULTA 11
   consultaRouter.get('/eliminarModelo', function (req, res) {
  
    consulta.eliminarModelo(function (result) {
      if (typeof result !== undefined) {
        res.json(result[0]);
  
      } else {
        res.json({ "mensaje": "No se pudo eliminar el Modelo" });
      }
    });
  });


  
  module.exports = consultaRouter;
  