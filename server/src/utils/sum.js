export const calcularDiarias = (dataEntrada, dataSaidaPrevista = null) => {
    const dataEntradaDate = new Date(dataEntrada);
    const hoje = new Date();
    const dataSaidaPrevistaDate = new Date(dataSaidaPrevista);


    const diarias = Math.floor((hoje - dataEntradaDate) / (1000 * 60 * 60 * 24));

    let diariasTotais = null;
    if (dataSaidaPrevista) {

        diariasTotais = Math.floor((dataSaidaPrevistaDate - dataEntradaDate) / (1000 * 60 * 60 * 24));
    }

    return { diarias, diariasTotais };
};

