import { getAllPets, getPetById, postPet, putPetById, deletePetById } from '../models/Pet.js';
import { validarTelefone, validarEspecie, validarDatas, validarFormatoData, formatarData, converterDataParaFormatoISO } from '../utils/validations.js';
import { calcularDiarias } from '../utils/sum.js';


export const getPets = async (req, res) => {
    try {
        const pets = await getAllPets();

        const petsComDiarias = pets.map(pet => {
            const petObject = pet.toObject();

            const dataEntradaISO = converterDataParaFormatoISO(petObject.dataEntrada);
            const dataSaidaPrevistaISO = converterDataParaFormatoISO(petObject.dataSaidaPrevista);

            return {
                ...petObject,
                ...calcularDiarias(dataEntradaISO, dataSaidaPrevistaISO)
            };
        });

        res.json(petsComDiarias);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Erro ao buscar pets' });
    }
};

export const getPet = async (req, res) => {
    try {
        const pet = await getPetById(req.params.id);
        if (!pet) return res.status(404).json({ error: 'Pet não encontrado' });

        res.json({
            ...pet.toObject(),
            ...calcularDiarias(pet.dataEntrada),
            ...calcularDiarias(pet.dataEntrada, pet.dataSaidaPrevista)
        });
    } catch (error) {
        res.status(500).json({ error: 'Erro ao buscar o pet' });
    }
};

export const createPet = async (req, res) => {

    try {
        const { nomeTutor, contatoTutor, especie, raca, dataEntrada, dataSaidaPrevista } = req.body;

        if (!nomeTutor || !contatoTutor || !especie || !dataEntrada) {
            return res.status(400).json({ error: 'Preencha todos os campos obrigatórios' });
        }

        if (!validarTelefone(contatoTutor)) {
            return res.status(400).json({ error: 'Formato de telefone inválido. Use: xxxxx-xxxx' });
        }

        if (!validarEspecie(especie)) {
            return res.status(400).json({ error: 'Espécie inválida. Escolha entre "cachorro" ou "gato"' });
        }

        if (!raca || raca.trim() === '') {
            return res.status(400).json({ error: 'A raça é obrigatória' });
        }


        if (!validarFormatoData(dataEntrada)) {
            return res.status(400).json({ error: 'Formato de data inválido. Use: DD/MM/AAAA' });
        }

        if (dataSaidaPrevista && !validarFormatoData(dataSaidaPrevista)) {
            return res.status(400).json({ error: 'Formato de data de saída inválido. Use: DD/MM/AAAA' });
        }

        const dataEntradaFormatada = formatarData(dataEntrada);
        const dataSaidaPrevistaFormatada = dataSaidaPrevista ? formatarData(dataSaidaPrevista) : null;

        validarDatas(dataEntradaFormatada, dataSaidaPrevistaFormatada);

        const novoPet = await postPet({
            ...req.body,
            dataEntrada: dataEntrada,
            dataSaidaPrevista: dataSaidaPrevista,
            especie: especie.toLowerCase()
        });

        res.status(201).json(novoPet);
    } catch (error) {
        res.status(400).json({ error: `Erro ao cadastrar o pet: ${error.message}` });
    }
};

export const updatePet = async (req, res) => {
    try {
        const petExistente = await getPetById(req.params.id);
        if (!petExistente) return res.status(404).json({ error: 'Pet não encontrado' });

        const { nomeTutor, contatoTutor, especie, raca, dataEntrada, dataSaidaPrevista } = req.body;


        if (especie && !validarEspecie(especie)) {
            return res.status(400).json({ error: 'Espécie inválida. Escolha entre "cachorro" ou "gato"' });
        }


        if (contatoTutor && !validarTelefone(contatoTutor)) {
            return res.status(400).json({ error: 'Formato de telefone inválido. Use: xxxxx-xxxx' });
        }


        if (raca && raca.trim() === '') {
            return res.status(400).json({ error: 'A raça não pode ser vazia' });
        }


        if (dataEntrada && !validarFormatoData(dataEntrada)) {
            return res.status(400).json({ error: 'Formato de data de entrada inválido. Use: DD/MM/AAAA' });
        }

        if (dataSaidaPrevista && !validarFormatoData(dataSaidaPrevista)) {
            return res.status(400).json({ error: 'Formato de data de saída inválido. Use: DD/MM/AAAA' });
        }


        const dataEntradaFormatada = dataEntrada ? formatarData(dataEntrada) : undefined;
        const dataSaidaPrevistaFormatada = dataSaidaPrevista ? formatarData(dataSaidaPrevista) : undefined;


        if (dataEntradaFormatada || dataSaidaPrevistaFormatada) {
            validarDatas(
                dataEntradaFormatada || petExistente.dataEntrada,
                dataSaidaPrevistaFormatada || petExistente.dataSaidaPrevista
            );
        }


        const updateData = {
            ...(nomeTutor && { nomeTutor }),
            ...(contatoTutor && { contatoTutor }),
            ...(especie && { especie: especie.toLowerCase() }),
            ...(raca && { raca }),
            ...(dataEntrada && { dataEntrada }),
            ...(dataSaidaPrevista && { dataSaidaPrevista })
        };

        const petAtualizado = await putPetById(req.params.id, updateData);

        res.json(petAtualizado);
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
