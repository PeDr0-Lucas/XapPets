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
export const validarFormatoData = (data) => {
    const dataRegex = /^\d{2}\/\d{2}\/\d{4}$/;
    if (!dataRegex.test(data)) return false;

    const [dia, mes, ano] = data.split('/').map(Number);

    if (mes < 1 || mes > 12) return false;

    const diasNoMes = new Date(ano, mes, 0).getDate();
    if (dia < 1 || dia > diasNoMes) return false;

    return true;
};

export const formatarData = (data) => {
    if (!data) return null;
    const [dia, mes, ano] = data.split('/');
    return new Date(`${ano}-${mes}-${dia}`);
};

export const converterDataParaFormatoISO = (dataString) => {
    if (!dataString) return null;

    const [dia, mes, ano] = dataString.split('/');

    return `${ano}-${mes.padStart(2, '0')}-${dia.padStart(2, '0')}`;
};