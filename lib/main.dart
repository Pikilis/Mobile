import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const PedraPapelTesouraApp());
}

class PedraPapelTesouraApp extends StatelessWidget {
  const PedraPapelTesouraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JokenpoGame(),
    );
  }
}

class JokenpoGame extends StatefulWidget {
  const JokenpoGame({super.key});

  @override
  State<JokenpoGame> createState() => _JokenpoGameState();
}

class _JokenpoGameState extends State<JokenpoGame> {
  final List<String> opcoes = ["pedra", "papel", "tesoura"];
  String escolhaUsuario = "";
  String escolhaApp = "";
  String resultado = "";
  int vitorias = 0;
  int empates = 0;
  int derrotas = 0;

  void jogar(String escolha) {
    setState(() {
      escolhaUsuario = escolha;
      escolhaApp = opcoes[Random().nextInt(3)];
      resultado = determinarResultado();

      if (resultado == "Vitória") {
        vitorias++;
      } else if (resultado == "Empate") {
        empates++;
      } else {
        derrotas++;
      }
    });
  }

  String determinarResultado() {
    if (escolhaUsuario == escolhaApp) {
      return "Empate";
    }
    if ((escolhaUsuario == "pedra" && escolhaApp == "tesoura") ||
        (escolhaUsuario == "tesoura" && escolhaApp == "papel") ||
        (escolhaUsuario == "papel" && escolhaApp == "pedra")) {
      return "Vitória";
    }
    return "Derrota";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pedra, Papel, Tesoura")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Escolha do App: $escolhaApp", style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          Text("Sua Escolha: $escolhaUsuario", style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          Text("Resultado: $resultado", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: opcoes.map((opcao) {
              return GestureDetector(
                onTap: () => jogar(opcao),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset("../assets/$opcao.png", width: 80),
                      Text(opcao.toUpperCase()),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Text("Placar: Vitórias: $vitorias | Empates: $empates | Derrotas: $derrotas",
              style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
