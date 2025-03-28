import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/pet_model.dart';
import '../provider/pet_provider.dart';
import 'editPet.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PetProvider>(context, listen: false).getPets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pets Hospedados'),
        centerTitle: true,
        backgroundColor: Colors.blue[600],
      ),
      body: Consumer<PetProvider>(
        builder: (context, petProvider, child) {
          if (petProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (petProvider.pets.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pets, size: 80, color: Colors.grey[400]),
                  SizedBox(height: 16),
                  Text(
                    'Nenhum pet cadastrado',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: petProvider.pets.length,
            itemBuilder: (context, index) {
              Pet pet = petProvider.pets[index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: _getSpecieColor(pet.especie),
                    child: Icon(
                      _getSpecieIcon(pet.especie),
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    pet.raca,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tutor: ${pet.nomeTutor}'),
                      Text('Entrada: ${pet.dataEntrada}'),
                      if (pet.dataSaidaPrevista != null)
                        Text(
                          'Saída Prevista: ${pet.dataSaidaPrevista}',
                          style: TextStyle(color: Colors.orange[700]),
                        ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PetEditScreen(pet: pet),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _confirmDeletePet(context, pet.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Passando um pet vazio com valores padrão
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => PetEditScreen(
                    pet: Pet(
                      id: '', // ID vazio para novo pet
                      nomeTutor: '',
                      contatoTutor: '',
                      especie: 'Cachorro', // valor padrão
                      raca: '',
                      dataEntrada: '',
                      dataSaidaPrevista: null,
                    ),
                  ),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[600],
      ),
    );
  }

  IconData _getSpecieIcon(String especie) {
    switch (especie.toLowerCase()) {
      case 'cachorro':
        return Icons.pets;
      case 'gato':
        return Icons.pets;
      default:
        return Icons.pets;
    }
  }

  Color _getSpecieColor(String especie) {
    switch (especie.toLowerCase()) {
      case 'cachorro':
        return Colors.brown;
      case 'gato':
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  void _confirmDeletePet(BuildContext context, String petId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Confirmar Exclusão'),
            content: Text('Tem certeza que deseja remover este pet?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<PetProvider>(
                    context,
                    listen: false,
                  ).deletePet(petId);
                  Navigator.pop(context);
                },
                child: Text('Confirmar'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
    );
  }
}
