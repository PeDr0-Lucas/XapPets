import mongoose from 'mongoose';

async function connectDb() {
    try {
        await mongoose.connect('mongodb+srv://xappapets:BqGNcB2RAsXoCi27@cluster0.pnikwct.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0')
    }
    catch (err) {
        console.log(`Erro: ${err}`)
    }

}





export default connectDb;
