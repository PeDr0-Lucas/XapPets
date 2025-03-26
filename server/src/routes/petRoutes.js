import express from 'express';
import { getPets, getPet, createPet, updatePet, deletePet } from '../controllers/petController.js';

const router = express.Router();

// Rota para obter todos os pets
router.get('/pets', getPets);

// Rota para obter um pet por ID
router.get('/pets/:id', getPet);

// Rota para criar um novo pet (método POST)
router.post('/pets', createPet);

// Rota para atualizar um pet existente
router.put('/pets/:id', updatePet);

// Rota para excluir um pet
router.delete('/pets/:id', deletePet);

export default router;
