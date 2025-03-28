import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/pet_model.dart';
import '../provider/pet_provider.dart';
import 'package:intl/intl.dart';

class PetEditScreen extends StatefulWidget {
  final Pet? pet;

  const PetEditScreen({Key? key, this.pet}) : super(key: key);

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

  String _selectedEspecie = 'cachorro';
  final List<String> _especies = ['cachorro', 'gato'];

  @override
  void initState() {
    super.initState();

    _nomeTutorController = TextEditingController(
      text: widget.pet?.nomeTutor ?? '',
    );
    _contatoTutorController = TextEditingController(
      text: widget.pet?.contatoTutor ?? '',
    );
    _racaController = TextEditingController(text: widget.pet?.raca ?? '');
    _dataEntradaController = TextEditingController(
      text: widget.pet?.dataEntrada ?? '',
    );
    _dataSaidaPrevistaController = TextEditingController(
      text: widget.pet?.dataSaidaPrevista ?? '',
    );

    if (widget.pet != null) {
      _selectedEspecie = widget.pet!.especie;
    }
  }

  @override
  void dispose() {
    _nomeTutorController.dispose();
    _contatoTutorController.dispose();
    _racaController.dispose();
    _dataEntradaController.dispose();
    _dataSaidaPrevistaController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final petProvider = Provider.of<PetProvider>(context, listen: false);

      final Pet newPet = Pet(
        id: widget.pet?.id ?? '',
        nomeTutor: _nomeTutorController.text,
        contatoTutor: _contatoTutorController.text,
        especie: _selectedEspecie,
        raca: _racaController.text,
        dataEntrada: _dataEntradaController.text,
        dataSaidaPrevista:
            _dataSaidaPrevistaController.text.isEmpty
                ? null
                : _dataSaidaPrevistaController.text,
      );

      if (widget.pet == null) {
        petProvider.addPet(newPet);
      } else {
        petProvider.updatePet(newPet);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pet == null ? 'Novo Pet' : 'Editar Pet'),
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
              TextFormField(
                controller: _nomeTutorController,
                decoration: InputDecoration(
                  labelText: 'Nome do Tutor',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do tutor';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: _contatoTutorController,
                decoration: InputDecoration(
                  labelText: 'Contato do Tutor',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o contato do tutor';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _selectedEspecie,
                decoration: InputDecoration(
                  labelText: 'Espécie',
                  prefixIcon: Icon(Icons.pets),
                  border: OutlineInputBorder(),
                ),
                items:
                    _especies.map((String especie) {
                      return DropdownMenuItem<String>(
                        value: especie,
                        child: Text(especie),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedEspecie = newValue!;
                  });
                },
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: _racaController,
                decoration: InputDecoration(
                  labelText: 'Raça',
                  prefixIcon: Icon(Icons.animation),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a raça';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: _dataEntradaController,
                decoration: InputDecoration(
                  labelText: 'Data de Entrada',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () => _selectDate(context, _dataEntradaController),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecione a data de entrada';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: _dataSaidaPrevistaController,
                decoration: InputDecoration(
                  labelText: 'Data de Saída Prevista (Opcional)',
                  prefixIcon: Icon(Icons.calendar_month),
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () => _selectDate(context, _dataSaidaPrevistaController),
              ),
              SizedBox(height: 24),

              ElevatedButton(
                onPressed: _submitForm,
                child: Text(
                  widget.pet == null ? 'Adicionar Pet' : 'Atualizar Pet',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
