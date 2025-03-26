export const validarTelefone = (telefone) => {
    const cell = /^\d{5}-\d{4}$/;
    return cell.test(telefone);
};

export const validarEspecie = (especie) => {
    const especiesValidas = ['cachorro', 'gato'];
    return especiesValidas.includes(especie.toLowerCase());
};

export const validarDatas = (dataEntrada, dataSaidaPrevista) => {
    const dataEntradaDate = new Date(dataEntrada);
    const hoje = new Date();

    if (dataEntradaDate > hoje) {
        throw new Error('A data de entrada não pode ser no futuro');
    }

    if (dataSaidaPrevista) {
        const dataSaidaDate = new Date(dataSaidaPrevista);
        if (dataSaidaDate <= dataEntradaDate) {
            throw new Error('A data de saída prevista deve ser posterior à data de entrada');
        }
    }
};
