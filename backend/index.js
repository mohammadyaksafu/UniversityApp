const express = require("express");
const app=express();
const mongoose= require("mongoose");

mongoose.connect("")

app.route("/").get((req,res)=>{
    res.json("App is running")
});

const PORT=process.env.port()||5000


app.listen(5000,
()=>console.log(`Server is Running ${PORT}`)
);