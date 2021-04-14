const mysql = require('mysql');


let mysql_parameters =  {
    host:"localhost",
    user:"*******",
    password:"*********",
    database:"GVE",
    port:"3306",
    insecureAuth:true
};

let connection = mysql.createConnection(mysql_parameters);

connection.connect((err)=>{
    if(err){
        throw err
    }else{
        console.log("CONNECTED");
    }
});

module.exports = connection;
