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
  // bool _hasAwardedPoints = false;

  Future<void> initializeGame() async {
    try {
      final result = await _resetGameUseCase();
      board = result.board;
      winner = '';
      isXTurn = true;
      // _hasAwardedPoints = false;
      notifyListeners();
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
      if (result.isNotEmpty && winner.isEmpty) {  // Only award points if winner hasn't been set
        winner = result;
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
    board = List.filled(9, ' ');
    isXTurn = true;
    winner = '';
    // _hasAwardedPoints = false;
    xoLogic = XoLogic();
    Player.playerX.clear();
    Player.playerO.clear();
    notifyListeners();
  }

  void newGame() {
    board = List.filled(9, ' ');
    isXTurn = true;
    winner = '';
    // _hasAwardedPoints = false;
    Player.playerXWin = 0;
    Player.playerOWin = 0;
    Player.playerX.clear();
    Player.playerO.clear();
    xoLogic = XoLogic();
    notifyListeners();
  }

  // AI game methods
  Future<void> makeAIMove(int position) async {
    if (board[position] == ' ' && winner.isEmpty) {
      try {
        board[position] = 'X';
        notifyListeners();

        final result = await _makeAIMoveUseCase(position);
        
        board = result.board;
        
        if (result.winner.isNotEmpty && winner.isEmpty) {  // Only award points if winner hasn't been set
          winner = result.winner;
          if (winner == 'X') {
            Player.playerXWin++;
          } else if (winner == 'O') {
            Player.playerOWin++;
          }
        }
        notifyListeners();
      } catch (e) {
        debugPrint('Error making AI move: $e');
        board[position] = ' ';
        notifyListeners();
      }
    }
  }

  Future<void> resetAIGame() async {
    try {
      final result = await _resetGameUseCase();
      board = result.board;
      winner = '';
      isXTurn = true;
      // _hasAwardedPoints = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error resetting AI game: $e');
    }
  }
}
