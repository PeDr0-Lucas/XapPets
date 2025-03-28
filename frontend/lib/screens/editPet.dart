import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/pet_model.dart';
import '../provider/pet_provider.dart';

class PetEditScreen extends StatefulWidget {
  final Pet pet;

  const PetEditScreen({Key? key, required this.pet}) : super(key: key);

  @override
  _PetEditScreenState createState() => _PetEditScreenState();
}

class _PetEditScreenState extends State<PetEditScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nomeTutorController;
  late TextEditingController _contatoTutorController;
  late TextEditingController _racaController;
  late TextEditingController _dataEntradaController;
  late TextEditingController _dataSaidaPrevistaController;

  late String _selectedEspecie;
  final List<String> especies = ['Cachorro', 'Gato'];

  @override
  void initState() {
    super.initState();

    _nomeTutorController = TextEditingController(text: widget.pet.nomeTutor);
    _contatoTutorController = TextEditingController(
      text: widget.pet.contatoTutor,
    );
    _racaController = TextEditingController(text: widget.pet.raca);
    _dataEntradaController = TextEditingController(
      text: widget.pet.dataEntrada,
    );
    _dataSaidaPrevistaController = TextEditingController(
      text: widget.pet.dataSaidaPrevista ?? '',
    );
    _selectedEspecie = widget.pet.especie;
  }

  Future<void> _updatePet() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final updatedPet = Pet(
      id: widget.pet.id,
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
      await Provider.of<PetProvider>(
        context,
        listen: false,
      ).updatePet(updatedPet);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pet atualizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao atualizar pet: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Pet'),
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
                onPressed: _updatePet,
                child: Text('Salvar Alterações'),
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
