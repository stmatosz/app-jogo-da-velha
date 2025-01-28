import 'package:flutter/material.dart';

class JogoDaVelha extends StatefulWidget {
  const JogoDaVelha({super.key});

  @override
  State<JogoDaVelha> createState() => _JogoDaVelhaState();
}

class _JogoDaVelhaState extends State<JogoDaVelha> {
  List<String> board = List.filled(9, ''); // Tabuleiro com 9 posições
  String currentPlayer = 'X'; // Jogador atual
  String winner = ''; // Vencedor

  // Verifica se há um vencedor
  void checkWinner() {
    // Combinações vencedoras
    const winningPositions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var positions in winningPositions) {
      if (board[positions[0]] == currentPlayer &&
          board[positions[1]] == currentPlayer &&
          board[positions[2]] == currentPlayer) {
        setState(() {
          winner = currentPlayer;
        });
        return;
      }
    }

    // Verifica empate
    if (!board.contains('') && winner == '') {
      setState(() {
        winner = 'Empate';
      });
    }
  }

  // Reinicia o jogo
  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      winner = '';
    });
  }

  // Atualiza o tabuleiro
  void updateBoard(int index) {
    if (board[index] == '' && winner == '') {
      setState(() {
        board[index] = currentPlayer;
        checkWinner();
        if (winner == '') {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogo da Velha'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Exibe o status do jogo
          Text(
            winner.isEmpty
                ? 'Vez do jogador: $currentPlayer'
                : winner == 'Empate'
                    ? 'Empate!'
                    : 'Vencedor: $winner',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          // Tabuleiro
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 colunas
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => updateBoard(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      board[index],
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          // Botão de reiniciar
          ElevatedButton(
            onPressed: resetGame,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text('Reiniciar Jogo'),
          ),
        ],
      ),
    );
  }
}
