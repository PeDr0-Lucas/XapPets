import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/pet_model.dart';

class ApiService {
  final String baseUrl = 'http://localhost:3000';

  Future<List<Pet>> getPets() async {
    final response = await http.get(Uri.parse('$baseUrl/pets'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print(data);
      return data.map((pet) => Pet.fromJson(pet)).toList();
    } else {
      throw Exception('Falha ao carregar pets: ${response.body}');
    }
  }

  Future<Pet> getPetById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/pets/$id'));

    if (response.statusCode == 200) {
      return Pet.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao carregar o pet: ${response.body}');
    }
  }

  Future<Pet> addPet(Pet pet) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pets'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode({
        'nomeTutor': pet.nomeTutor,
        'contatoTutor': pet.contatoTutor,
        'especie': pet.especie,
        'raca': pet.raca,
        'dataEntrada': pet.dataEntrada,
        'dataSaidaPrevista': pet.dataSaidaPrevista,
      }),
    );

    if (response.statusCode == 201) {
      return Pet.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao adicionar pet: ${response.body}');
    }
  }

  Future<Pet> updatePet(Pet pet) async {
    final response = await http.put(
      Uri.parse('$baseUrl/pets/${pet.id}'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode({
        'nomeTutor': pet.nomeTutor,
        'contatoTutor': pet.contatoTutor,
        'especie': pet.especie,
        'raca': pet.raca,
        'dataEntrada': pet.dataEntrada,
        'dataSaidaPrevista': pet.dataSaidaPrevista,
      }),
    );

    if (response.statusCode == 200) {
      return Pet.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao atualizar pet: ${response.body}');
    }
  }

  Future<void> deletePet(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/pets/$id'));

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar pet: ${response.body}');
    }
  }
}
