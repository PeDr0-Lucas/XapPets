import mongoose from 'mongoose';


const petSchema = new mongoose.Schema({
    nomeTutor: {
        type: String,
        required: true,
    },
    contatoTutor: {
        type: String,
        required: true,
    },
    especie: {
        type: String,
        required: true,
        enum: ['cachorro', 'gato', 'Cachorro', 'Gato'], // Aceita ambas as versões
        set: (val) => val.toLowerCase(), // Converte para minúsculo antes de armazenar
    },
    raca: {
        type: String,
        required: true,
    },
    dataEntrada: {
        type: Date,
        required: true,
    },
    dataSaidaPrevista: {
        type: Date,
    },
});

export default petSchema

