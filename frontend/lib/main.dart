import 'package:flutter/material.dart';
import 'teste.dart'; // Importando a tela de teste

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Animais',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TestScreen(), // Exibindo a tela de teste
    );
  }
}
