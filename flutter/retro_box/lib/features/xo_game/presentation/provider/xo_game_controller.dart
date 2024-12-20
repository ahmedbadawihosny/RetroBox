import 'package:flutter/material.dart';
import 'package:retro_box/core/services/service_locator.dart';
import 'package:retro_box/features/xo_game/domain/entites/player.dart';
import 'package:retro_box/features/xo_game/domain/services/xo_logic.dart';
import 'package:retro_box/features/xo_game/domain/usecases/make_ai_move.dart';
import 'package:retro_box/features/xo_game/domain/usecases/reset_game.dart';

class XoGameController with ChangeNotifier {
  final MakeAIMove _makeAIMoveUseCase;
  final ResetGame _resetGameUseCase;
  
  XoGameController()
      : _makeAIMoveUseCase = getIt<MakeAIMove>(),
        _resetGameUseCase = getIt<ResetGame>() {
    initializeGame();
  }

  List<String> board = List.filled(9, ' ');
  String winner = '';
  bool isXTurn = true;
  XoLogic xoLogic = XoLogic();
  bool _hasAwardedPoints = false;

  Future<void> initializeGame() async {
    try {
      final result = await _resetGameUseCase();
      setState(() {
        board = result.board;
        winner = '';
        isXTurn = true;
        _hasAwardedPoints = false;
      });
    } catch (e) {
      debugPrint('Error initializing game: $e');
    }
  }

  // Local game methods
  void handleTap(int index) {
    if (board[index] == ' ' && winner.isEmpty) {
      String activePlayer = isXTurn ? Player.x : Player.o;
      board[index] = activePlayer;
      xoLogic.playGame(activePlayer, index);
      
      String result = xoLogic.checkWinner();
      if (result.isNotEmpty && !_hasAwardedPoints) {
        winner = result;
        _hasAwardedPoints = true;
        if (winner == 'X') {
          Player.playerXWin++;
        } else if (winner == 'O') {
          Player.playerOWin++;
        }
      } else if (!board.contains(' ')) {
        winner = 'Draw';
      }
      
      isXTurn = !isXTurn;
      notifyListeners();
    }
  }

  void resetFriendGame() {
    setState(() {
      board = List.filled(9, ' ');
      isXTurn = true;
      winner = '';
      _hasAwardedPoints = false;
      xoLogic = XoLogic();
      Player.playerX.clear();
      Player.playerO.clear();
    });
  }

  void newGame() {
    setState(() {
      board = List.filled(9, ' ');
      isXTurn = true;
      winner = '';
      _hasAwardedPoints = false;
      Player.playerXWin = 0;
      Player.playerOWin = 0;
      Player.playerX.clear();
      Player.playerO.clear();
      xoLogic = XoLogic();
    });
  }

  // AI game methods
  Future<void> makeAIMove(int position) async {
    if (board[position] == ' ' && winner.isEmpty) {
      try {
        setState(() {
          board[position] = 'X';
        });

        final result = await _makeAIMoveUseCase(position);
        
        setState(() {
          board = result.board;
          winner = result.winner;
          
          if (winner.isNotEmpty && !_hasAwardedPoints) {
            _hasAwardedPoints = true;
            if (winner == 'X') {
              Player.playerXWin++;
            }
            if (winner == 'O') {
              Player.playerOWin++;
            }
          }
        });
      } catch (e) {
        debugPrint('Error making AI move: $e');
        setState(() {
          board[position] = ' ';
        });
      }
    }
  }

  Future<void> resetAIGame() async {
    try {
      final result = await _resetGameUseCase();
      setState(() {
        board = result.board;
        winner = '';
        isXTurn = true;
        _hasAwardedPoints = false;
      });
    } catch (e) {
      debugPrint('Error resetting AI game: $e');
    }
  }

  void setState(Function() fn) {
    fn();
    notifyListeners();
  }
}
