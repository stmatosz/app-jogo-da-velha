import 'package:flutter/material.dart';
import 'jogo_da_velha.dart'; // Importa o arquivo do jogo da velha

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jogo da Velha',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const JogoDaVelha(), // Direciona para o jogo
    );
  }
}
