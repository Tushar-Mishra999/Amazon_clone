const express= require('express');
const mongoose=require('mongoose');
const app=express();
const PORT=3000;
const authRouter=require('./router/auth');
const adminRouter=require('./router/admin');
const productRouter=require('./router/product');
const userRouter = require('./router/user');
const DB="mongodb+srv://Tushar:Tushar@cluster0.qyj5qwu.mongodb.net/?retryWrites=true&w=majority";
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);
mongoose.connect(DB).then(()=>{
    console.log("Mongo Connection Successful");
}).catch((e)=>{console.log(e);})

app.listen(PORT,()=>{
    console.log(`connected at port ${PORT}`);
})
