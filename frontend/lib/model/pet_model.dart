class Pet {
  final String id;
  final String nomeTutor;
  final String contatoTutor;
  final String especie;
  final String raca;
  final String dataEntrada;
  final String? dataSaidaPrevista;

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
}
