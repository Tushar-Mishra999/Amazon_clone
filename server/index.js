const express= require('express');
const mongoose=require('mongoose');
const app=express();
const PORT=3000;
const authRouter=require('./router/auth');
const DB="mongodb+srv://Tushar:Tushar@cluster0.qyj5qwu.mongodb.net/?retryWrites=true&w=majority";
app.use(express.json());
app.use(authRouter);

mongoose.connect(DB).then(()=>{
    console.log("Mongo Connection Successful");
}).catch((e)=>{console.log(e);})

app.listen(PORT,()=>{
    console.log(`connected at port ${PORT}`);
})
