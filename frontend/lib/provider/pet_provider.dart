import 'package:flutter/foundation.dart';
import '../model/pet_model.dart';
import '../services/api_service.dart';

class PetProvider with ChangeNotifier {
  List<Pet> _pets = [];
  bool _isLoading = false;
  final ApiService _apiService = ApiService();

  List<Pet> get pets => _pets;
  bool get isLoading => _isLoading;

  Future<void> getPets() async {
    _isLoading = true;
    notifyListeners();

    try {
      _pets = await _apiService.getPets();
    } catch (e) {
      _pets = [];
      print('Erro ao buscar pets: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addPet(Pet pet) async {
    try {
      final newPet = await _apiService.addPet(pet);
      _pets.add(newPet);
      notifyListeners();
    } catch (e) {
      print('Erro ao adicionar pet: $e');
    }
  }

  Future<void> updatePet(Pet pet) async {
    try {
      final updatedPet = await _apiService.updatePet(pet);
      final index = _pets.indexWhere((p) => p.id == pet.id);
      if (index != -1) {
        _pets[index] = updatedPet;
        notifyListeners();
      }
    } catch (e) {
      print('Erro ao atualizar pet: $e');
    }
  }

  Future<void> deletePet(String id) async {
    try {
      await _apiService.deletePet(id);
      _pets.removeWhere((pet) => pet.id == id);
      notifyListeners();
    } catch (e) {
      print('Erro ao deletar pet: $e');
    }
  }
}
