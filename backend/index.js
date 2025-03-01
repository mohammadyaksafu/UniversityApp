const express = require("express");
const mongoose= require("mongoose");

require('dotenv').config();


const app=express();
//mongoose.connect("")

app.route("/").get((req,res)=>{
    res.json("App is running")
});

const PORT=process.env.PORT||5000;


app.listen(PORT,
()=>console.log(`Server is Running at http://localhost:${PORT}`)
);