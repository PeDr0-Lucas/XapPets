class Pet {
  final String _id;
  final String nomeTutor;
  final String contatoTutor;
  final String especie;
  final String raca;
  final String dataEntrada;
  final String? dataSaidaPrevista;
  final int diarias;
  final int diariasTotais;

  Pet({
    required String id,
    required this.nomeTutor,
    required this.contatoTutor,
    required this.especie,
    required this.raca,
    required this.dataEntrada,
    this.dataSaidaPrevista,
    this.diarias = 0,
    this.diariasTotais = 0,
  }) : _id = id;

  String get id => _id;

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['_id'] ?? '',
      nomeTutor: json['nomeTutor'] ?? '',
      contatoTutor: json['contatoTutor'] ?? '',
      especie: json['especie'] ?? '',
      raca: json['raca'] ?? '',
      dataEntrada: json['dataEntrada'] ?? '',
      dataSaidaPrevista: json['dataSaidaPrevista'],
      diarias: json['diarias'] ?? 0,
      diariasTotais: json['diariasTotais'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': _id,
      'nomeTutor': nomeTutor,
      'contatoTutor': contatoTutor,
      'especie': especie,
      'raca': raca,
      'dataEntrada': dataEntrada,
      'dataSaidaPrevista': dataSaidaPrevista,
      'diarias': diarias,
      'diariasTotais': diariasTotais,
    };
  }
}
