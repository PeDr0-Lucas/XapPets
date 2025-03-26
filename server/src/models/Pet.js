import mongoose from 'mongoose';

// Função para calcular as diárias
const calcularDiarias = (dataEntrada, dataSaida) => {
    const dataEntradaDate = new Date(dataEntrada);
    const dataSaidaDate = new Date(dataSaida || Date.now()); // Caso não tenha data de saída, usa a data atual
    const dias = Math.floor((dataSaidaDate - dataEntradaDate) / (1000 * 60 * 60 * 24)); // Converte milissegundos para dias
    return dias >= 0 ? dias : 0; // Garantir que as diárias não sejam negativas
};

// Função para calcular as diárias totais previstas
const calcularDiariasTotais = (dataEntrada, dataSaidaPrevista) => {
    if (!dataSaidaPrevista) return 0; // Se não houver previsão de saída, retorna 0
    return calcularDiarias(dataEntrada, dataSaidaPrevista);
};

const petSchema = new mongoose.Schema({
    nomeTutor: { type: String, required: true },
    contatoTutor: { type: String, required: true },
    especie: {
        type: String,
        enum: ['Cachorro', 'Gato'],
        required: true
    },
    raca: { type: String, required: true },
    dataEntrada: {
        type: Date,
        required: true
    },
    dataSaidaPrevista: Date,
    diarias: {
        type: Number,
        default: function () {
            return calcularDiarias(this.dataEntrada, this.dataSaidaPrevista);
        }
    },
    diariasTotais: {
        type: Number,
        default: function () {
            return calcularDiariasTotais(this.dataEntrada, this.dataSaidaPrevista);
        }
    }
});

// Hook de Mongoose para recalcular as diárias quando a data de saída prevista for atualizada
petSchema.pre('save', function (next) {
    this.diarias = calcularDiarias(this.dataEntrada, this.dataSaidaPrevista);
    this.diariasTotais = calcularDiariasTotais(this.dataEntrada, this.dataSaidaPrevista);
    next();
});

const Pet = mongoose.model('Pet', petSchema);

// Funções de manipulação de dados

export const getAllPets = async () => {
    try {
        return await Pet.find();
    } catch (error) {
        throw new Error(`Erro ao buscar todos os pets: ${error.message}`);
    }
}

export const getPetById = async (id) => {
    try {
        return await Pet.findById(id);
    } catch (error) {
        throw new Error(`Erro ao buscar o pet: ${error.message}`);
    }
}

export const postPet = async (pet) => {
    try {
        const novoPet = new Pet(pet);
        return await novoPet.save();
    } catch (error) {
        throw new Error(`Erro ao inserir o pet: ${error.message}`);
    }
}

export const putPetById = async (id, pet) => {
    try {
        if (!mongoose.Types.ObjectId.isValid(id)) {
            throw new Error(`Id inválido: ${id}`);
        }
        const petAtualizado = await Pet.findByIdAndUpdate(id, pet, { new: true });
        if (!petAtualizado) {
            throw new Error(`Erro ao atualizar o pet com o id: ${id}`);
        }
        return petAtualizado;
    } catch (error) {
        throw new Error(`Erro ao atualizar o pet: ${error.message}`);
    }
}

export const deletePetById = async (id) => {
    try {
        if (!mongoose.Types.ObjectId.isValid(id)) {
            throw new Error('ID inválido');
        }
        const petDeletado = await Pet.findByIdAndDelete(id);
        if (!petDeletado) {
            throw new Error('Pet não encontrado');
        }
        return { message: 'Pet excluído com sucesso' };
    } catch (error) {
        throw new Error(`Erro ao excluir o pet: ${error.message}`);
    }
};

export { Pet };
