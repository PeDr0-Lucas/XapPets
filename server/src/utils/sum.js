export const calcularDiarias = (dataEntrada, dataSaidaPrevista = null) => {
    const dataEntradaDate = new Date(dataEntrada);
    const hoje = new Date();

    // Calcular diárias passadas (desde a data de entrada até hoje)
    const diarias = Math.floor((hoje - dataEntradaDate) / (1000 * 60 * 60 * 24));

    // Calcular diárias totais previstas, se houver data de saída prevista
    let diariasTotais = null;  // Inicializa como null (não aplicável)
    if (dataSaidaPrevista) {
        const dataSaidaPrevistaDate = new Date(dataSaidaPrevista);
        diariasTotais = Math.floor((dataSaidaPrevistaDate - dataEntradaDate) / (1000 * 60 * 60 * 24));
    }

    return { diarias, diariasTotais };
};
