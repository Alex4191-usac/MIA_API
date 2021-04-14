const express = require('express');

const app = express();

const port = process.env.PORT || 3034;


const con_mysql = require('./config');

app.use(express.json());



let temporal = require('./routes/temporal_routes');
let consult = require('./routes/consulta_routes');

app.use("/", temporal);
app.use("/",consult);



/*app.use(function(req, res, next) {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Authorization');
      next();
  });
*/




app.listen(port, ()=>{
    console.log(`Server is running on port: ${port}`);
});

