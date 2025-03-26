import mongoose from 'mongoose';
import dotenv from 'dotenv';

dotenv.config();

async function connectDb() {
    try {
        await mongoose.connect(process.env.MONGO_URI)
        console.log('Conectado ao MongoDB')
    } catch (err) {
        console.log(`Erro: ${err}`);
    }
}

export default connectDb;