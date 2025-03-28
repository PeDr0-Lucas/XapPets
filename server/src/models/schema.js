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
        enum: ['cachorro', 'gato', 'Cachorro', 'Gato'],
        set: (val) => val.toLowerCase(),
    },
    raca: {
        type: String,
        required: true,
    },
    dataEntrada: {
        type: String,
        required: true,
    },
    dataSaidaPrevista: {
        type: String,
    },
});

export default petSchema

