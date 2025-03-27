import express from 'express'
import petRoutes from './routes/petRoutes.js'
import dotenv from 'dotenv'
import connectDb from './database/db.js'
import cors from 'cors'

dotenv.config()
connectDb()

const app = express()
app.use(cors())


app.use(express.json())
app.use(petRoutes)


connectDb().then(() => {
    app.listen(3000, () => {
        console.log('Server is running on http://localhost:3000')
    })
}).catch(err => {
    console.log(`Erro: ${err}`)
})

