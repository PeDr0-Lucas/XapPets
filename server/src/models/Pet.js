import mongoose from 'mongoose';
import petSchema from './schema.js';


const Pet = mongoose.model('Pet', petSchema);


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
