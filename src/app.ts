import express from 'express'
import logger from 'morgan';
const app = express()

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.get('/',(req,res)=>{
    console.log(111112111)
    console.log(`${process.env.NODE_ENV}`)
    res.status(200).send('OK to "1111111/"')
})
app.get('/test',(req,res)=>{
    res.status(200).send('OK to "/test1"')
})
app.get('/err',(req,res)=>{
    throw new Error()
    res.status(500).send('ERROR"')
})
app.listen(process.env.PORT,()=>console.log(`111111${process.env.PORT}${process.env.NODE_ENV}`))