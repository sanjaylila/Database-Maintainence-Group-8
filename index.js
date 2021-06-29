import express from 'express'
import client from "./connection/connection.js"
import dotenv from 'dotenv'
dotenv.config()
import cors from 'cors'

const app=express()
app.use(cors())

app.use(express.json())


app.listen(5000,()=>{
    console.log("connection was success")
})
