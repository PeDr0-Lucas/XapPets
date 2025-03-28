import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/pet_model.dart';
import '../provider/pet_provider.dart';
import 'package:uuid/uuid.dart'; // Para gerar ID único

class AddPetPage extends StatefulWidget {
  @override
  _AddPetPageState createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto
  late TextEditingController _nomeTutorController;
  late TextEditingController _contatoTutorController;
  late TextEditingController _racaController;
  late TextEditingController _dataEntradaController;
  late TextEditingController _dataSaidaPrevistaController;

  // Variáveis para dropdown
  late String _selectedEspecie;
  final List<String> _especies = ['Cachorro', 'Gato'];

  @override
  void initState() {
    super.initState();

    // Inicializa controladores
    _nomeTutorController = TextEditingController();
    _contatoTutorController = TextEditingController();
    _racaController = TextEditingController();
    _dataEntradaController = TextEditingController();
    _dataSaidaPrevistaController = TextEditingController();
    _selectedEspecie = _especies.first;
  }

  Future<void> _addPet() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Gerar um ID único
    final petId = Uuid().v4();

    final newPet = Pet(
      id: petId,
      nomeTutor: _nomeTutorController.text,
      contatoTutor: _contatoTutorController.text,
      especie: _selectedEspecie,
      raca: _racaController.text,
      dataEntrada: _dataEntradaController.text,
      dataSaidaPrevista:
          _dataSaidaPrevistaController.text.isNotEmpty
              ? _dataSaidaPrevistaController.text
              : null,
    );

    try {
      await Provider.of<PetProvider>(context, listen: false).addPet(newPet);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pet adicionado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop(); // Volta à tela anterior
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao adicionar pet: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Pet'),
        centerTitle: true,
        backgroundColor: Colors.blue[600],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Campos do formulário
              TextFormField(
                controller: _nomeTutorController,
                decoration: InputDecoration(
                  labelText: 'Nome do Tutor',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o nome do tutor';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // ... outros campos (contato, espécie, raça, etc.)
              ElevatedButton(
                onPressed: _addPet,
                child: Text('Salvar Pet'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
