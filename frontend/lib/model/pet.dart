class Pet {
  final String id;
  final String nomeTutor; // Nome do tutor
  final String contatoTutor; // Contato do tutor
  final String especie; // Espécie (Cachorro ou Gato)
  final String raca; // Raça
  final String dataEntrada; // Data de entrada
  final String? dataSaidaPrevista; // Data de saída prevista, que pode ser nula

  Pet({
    required this.id,
    required this.nomeTutor,
    required this.contatoTutor,
    required this.especie,
    required this.raca,
    required this.dataEntrada,
    this.dataSaidaPrevista,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['_id'],
      nomeTutor: json['nomeTutor'],
      contatoTutor: json['contatoTutor'],
      especie: json['especie'],
      raca: json['raca'],
      dataEntrada: json['dataEntrada'],
      dataSaidaPrevista: json['dataSaidaPrevista'],
    );
  }

  // Método para calcular as diárias até o momento
  int calcularDiarias() {
    final dataEntrada = DateTime.parse(this.dataEntrada);
    final dataAtual = DateTime.now();
    final diasHospedagem = dataAtual.difference(dataEntrada).inDays;

    return diasHospedagem > 0 ? diasHospedagem : 0;
  }

  // Método para calcular as diárias totais previstas
  int calcularDiariasTotais() {
    if (dataSaidaPrevista == null || dataSaidaPrevista!.isEmpty) {
      return 0; // Se não houver previsão de saída, retorna 0
    }
    final dataSaida = DateTime.parse(dataSaidaPrevista!);
    final diasHospedagemTotal =
        dataSaida.difference(DateTime.parse(dataEntrada)).inDays;

    return diasHospedagemTotal > 0
        ? diasHospedagemTotal
        : 0; // Retorna 0 se a data de saída for inválida
  }
}
