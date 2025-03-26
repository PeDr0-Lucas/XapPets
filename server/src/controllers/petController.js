import { getAllPets, getPetById, postPet, putPetById, deletePetById } from '../models/Pet.js';

export const getPets = async (req, res) => {
    try {
        const pets = await getAllPets();
        res.json(pets);
    } catch (error) {
        res.status(500).json({ error: 'Erro ao buscar pets' });
    }
};

export const getPet = async (req, res) => {
    try {
        const pet = await getPetById(req.params.id);
        if (!pet) return res.status(404).json({ error: 'Pet não encontrado' });
        res.json(pet);
    } catch (error) {
        res.status(500).json({ error: 'Erro ao buscar o pet' });
    }
};

export const createPet = async (req, res) => {
    try {
        const newPet = await postPet(req.body);
        res.status(201).json(newPet);
    } catch (error) {
        res.status(400).json({ error: 'Erro ao cadastrar o pet' });
    }
};

export const updatePet = async (req, res) => {
    try {
        const updatedPet = await putPetById(req.params.id, req.body);
        if (!updatedPet) return res.status(404).json({ error: 'Pet não encontrado' });
        res.json(updatedPet);
    } catch (error) {
        res.status(400).json({ error: 'Erro ao atualizar o pet' });
    }
};

export const deletePet = async (req, res) => {
    try {
        const deletedPet = await deletePetById(req.params.id);
        if (!deletedPet) return res.status(404).json({ error: 'Pet não encontrado' });
        res.json({ message: 'Pet excluído com sucesso' });
    } catch (error) {
        res.status(500).json({ error: 'Erro ao excluir o pet' });
    }
};
