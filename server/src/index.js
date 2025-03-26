import express from 'express'
import connectDb from './database/db.js'
import petRoutes from './routes/petRoutes.js'

const app = express()


app.use(express.json())
app.use(petRoutes)


connectDb().then(() => {
    app.listen(3000, () => {
        console.log('Server is running on http://localhost:3000')
    })
}).catch(err => {
    console.log(`Erro: ${err}`)
})

