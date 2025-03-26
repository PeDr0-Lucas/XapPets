import { getAllPets, getPetById, postPet, putPetById, deletePetById } from '../models/Pet.js';

const validarTelefone = (telefone) => {
    const cell = /^\d{5}-\d{4}$/;
    return cell.test(telefone);
};

export const getPets = async (req, res) => {
    try {
        const pets = await getAllPets();


        const petsComDiarias = pets.map(pet => {
            const dataEntrada = new Date(pet.dataEntrada);
            const hoje = new Date();
            const diarias = Math.floor((hoje - dataEntrada) / (1000 * 60 * 60 * 24));

            const dataSaidaPrevista = pet.dataSaidaPrevista ? new Date(pet.dataSaidaPrevista) : null;
            let diariasTotais = 0;
            if (dataSaidaPrevista) {
                diariasTotais = Math.floor((dataSaidaPrevista - dataEntrada) / (1000 * 60 * 60 * 24));
            }


            pet.diarias = diarias;
            pet.diariasTotais = diariasTotais;
            return pet;
        });

        res.json(petsComDiarias);
    } catch (error) {
        res.status(500).json({ error: 'Erro ao buscar pets' });
    }
};

export const getPet = async (req, res) => {
    try {
        const pet = await getPetById(req.params.id);
        if (!pet) return res.status(404).json({ error: 'Pet não encontrado' });


        const dataEntrada = new Date(pet.dataEntrada);
        const hoje = new Date();
        const diarias = Math.floor((hoje - dataEntrada) / (1000 * 60 * 60 * 24));

        const dataSaidaPrevista = pet.dataSaidaPrevista ? new Date(pet.dataSaidaPrevista) : null;
        let diariasTotais = 0;
        if (dataSaidaPrevista) {
            diariasTotais = Math.floor((dataSaidaPrevista - dataEntrada) / (1000 * 60 * 60 * 24));
        }


        pet.diarias = diarias;
        pet.diariasTotais = diariasTotais;

        res.json(pet);
    } catch (error) {
        res.status(500).json({ error: 'Erro ao buscar o pet' });
    }
};

export const createPet = async (req, res) => {
    try {
        const { nomeTutor, contatoTutor, especie, raca, dataEntrada, dataSaidaPrevista } = req.body;

        if (!nomeTutor || !contatoTutor || !especie || !dataEntrada) {
            return res.status(400).json({ error: 'Preencha todos os campos obrigatórios: nomeTutor, contatoTutor, especie e dataEntrada' });
        }

        if (!validarTelefone(contatoTutor)) {
            return res.status(400).json({ error: 'Formato de telefone inválido. Use: xxxxx-xxx' });
        }

        const especiesValidas = ['Cachorro', 'Gato'];
        if (!especiesValidas.includes(especie)) {
            return res.status(400).json({ error: 'Espécie inválida. Escolha entre "Cachorro" ou "Gato"' });
        }

        const dataEntradaDate = new Date(dataEntrada);
        const hoje = new Date();
        if (dataEntradaDate > hoje) {
            return res.status(400).json({ error: 'A data de entrada não pode ser no futuro' });
        }

        if (dataSaidaPrevista) {
            const dataSaidaDate = new Date(dataSaidaPrevista);
            if (dataSaidaDate <= dataEntradaDate) {
                return res.status(400).json({ error: 'A data de saída prevista deve ser posterior à data de entrada' });
            }
        }


        const newPet = await postPet(req.body);
        res.status(201).json(newPet);
    } catch (error) {
        res.status(400).json({ error: `Erro ao cadastrar o pet: ${error.message}` });
    }
};

export const updatePet = async (req, res) => {
    try {

        const petExistente = await getPetById(req.params.id);
        if (!petExistente) return res.status(404).json({ error: 'Pet não encontrado' });

        const { nomeTutor, contatoTutor, especie, raca, dataEntrada, dataSaidaPrevista } = req.body;


        if (!nomeTutor || !contatoTutor || !especie || !dataEntrada) {
            return res.status(400).json({ error: 'Preencha todos os campos obrigatórios: nomeTutor, contatoTutor, especie e dataEntrada' });
        }


        if (!validarTelefone(contatoTutor)) {
            return res.status(400).json({ error: 'Formato de telefone inválido. Use: xxxxx-xxx' });
        }


        const especiesValidas = ['Cachorro', 'Gato'];
        if (!especiesValidas.includes(especie)) {
            return res.status(400).json({ error: 'Espécie inválida. Escolha entre "Cachorro" ou "Gato"' });
        }


        const dataEntradaDate = new Date(dataEntrada);
        const hoje = new Date();
        if (dataEntradaDate > hoje) {
            return res.status(400).json({ error: 'A data de entrada não pode ser no futuro' });
        }


        if (dataSaidaPrevista) {
            const dataSaidaDate = new Date(dataSaidaPrevista);
            if (dataSaidaDate <= dataEntradaDate) {
                return res.status(400).json({ error: 'A data de saída prevista deve ser posterior à data de entrada' });
            }
        }


        const updatedPet = await putPetById(req.params.id, req.body);
        res.json(updatedPet);
    } catch (error) {
        res.status(400).json({ error: `Erro ao atualizar o pet: ${error.message}` });
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
