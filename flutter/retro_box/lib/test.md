```dart
// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:retro_box/core/constants/app_colors.dart';
import 'package:retro_box/core/widgets/custom_app_bar.dart';
import 'package:retro_box/core/widgets/custom_app_btn.dart';
import 'package:retro_box/features/xo_game/domain/entites/player.dart';
import 'package:retro_box/features/xo_game/domain/services/xo_logic.dart';
import 'package:retro_box/features/xo_game/presentation/widgets/xo_game_score.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class XoGameSession extends StatefulWidget {
  final String session;
  const XoGameSession({super.key, required this.session});

  @override
  State<XoGameSession> createState() => _XoGameSessionState(session);
}

class _XoGameSessionState extends State<XoGameSession> {
  final String session;
  _XoGameSessionState(this.session);

  List<String> board = List.filled(9, ' ');
  String winner = '';

  bool isXTurn = true;
  XoLogic xoLogic = XoLogic();

  // Api methods
  Future<void> makeAIMove(int position) async {
    if (board[position] == ' ' && winner == '') {
      try {
        setState(() {
          board[position] = 'X';
        });
        final response = await http.get(
          Uri.parse(
              'https://retrobox-api.vercel.app/xo/move?position=$position'),
        );
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data['board'] != null) {
            setState(() {
              board = List<String>.from(data['board']);
              winner = data['winner'] ?? '';
            });
          } else {
            throw Exception('Invalid response format from server.');
          }
        } else {
          throw Exception(
              'Server responded with status code ${response.statusCode}');
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: Could not make a move.')),
        );
      }
    }

    if (winner != '') {
      if (winner == 'X') {
        Player.playerXWin++;
      }
      if (winner == 'O') {
        Player.playerOWin++;
      }
      _showWinnerDialog(winner);
    } else if (!board.contains(' ')) {
      _showWinnerDialog('Draw');
    }
  }

  // Function to reset the game
  Future<void> resetAIGame() async {
    var response = await http.get(
      Uri.parse('https://retrobox-api.vercel.app/xo/reset'),
    );
    var data = json.decode(response.body);
    setState(() {
      board = List.from(data['board']);
      winner = '';
    });
  }

  // local logic
  void resetFriendGame() {
    setState(() {
      board = List.filled(9, ' ');
      isXTurn = true;
      Player.playerX.clear();
      Player.playerO.clear();
    });
  }

  void newGame() {
    setState(() {
      board = List.filled(9, ' ');
      isXTurn = true;
      Player.playerXWin = 0;
      Player.playerOWin = 0;
      Player.playerX.clear();
      Player.playerO.clear();
    });
  }

  void handleTap(int index) {
    if (board[index] == ' ') {
      setState(() {
        String activePlayer = isXTurn ? Player.x : Player.o;
        board[index] = activePlayer;
        xoLogic.playGame(activePlayer, index);
        String winner = xoLogic.checkWinner();
        if (winner != '') {
          _showWinnerDialog(winner);
        } else if (!board.contains(' ')) {
          _showWinnerDialog('Draw');
        }
        isXTurn = !isXTurn;
      });
    }
  }

  void _showWinnerDialog(String winner) {
    String message = winner == 'Draw' ? "It's a draw!" : 'Player $winner wins!';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                session == 'AI_Game' ? resetAIGame() : resetFriendGame();
              },
              child: const Text('New Game'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: customAppBar(
        barTitle: 'Tic Tac Toe',
        barIcon: Icons.arrow_back_ios_new_rounded,
        barFunc: () {
          Navigator.pop(context);
          newGame();
        },
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        session == 'AI_Game'
            ? XoGameScore(
                secondPlayer: 'bot',
              )
            : XoGameScore(
                secondPlayer: 'Friend',
              ),
        const SizedBox(
          height: 30,
        ),
        gameBoard(),
        const SizedBox(
          height: 30,
        ),
        CustomAppBtn(
          btnTitle: 'Reset Game',
          btnColor: AppColor.primary,
          btnFun: () =>
              session == 'AI_Game' ? resetAIGame() : resetFriendGame(),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomAppBtn(
          btnTitle: 'New Game',
          btnColor: AppColor.white,
          btnFun: () => session == 'AI_Game' ? newGame() : resetAIGame(),
        ),
        const SizedBox(
          height: 20,
        ),
      ]),
    );
  }

  Padding gameBoard() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: 9,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () =>
                session == 'AI_Game' ? makeAIMove(index) : handleTap(index),
            child: Container(
              margin: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: AppColor.xoBoard,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  board[index],
                  style: TextStyle(
                    color: board[index] == Player.x
                        ? AppColor.playerX
                        : AppColor.playerO,
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

````