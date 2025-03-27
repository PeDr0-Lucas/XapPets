import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/model/pet.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  ApiService apiService = ApiService();
  String responseMessage = '';

  @override
  void initState() {
    super.initState();
    _testConnection();
  }

  // Método para testar a conexão com a API
  Future<void> _testConnection() async {
    try {
      List<Pet> pets =
          await apiService.getPets(); // Método para pegar todos os pets
      setState(() {
        responseMessage =
            'Conexão bem-sucedida! Número de pets: ${pets.length}';
      });
    } catch (e) {
      setState(() {
        responseMessage = 'Falha ao conectar ao servidor: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Testar Conexão')),
      body: Center(
        child: Text(responseMessage, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
