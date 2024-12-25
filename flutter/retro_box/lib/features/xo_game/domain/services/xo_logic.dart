import 'package:retro_box/features/xo_game/domain/entites/player.dart';

class XoLogic {
  void playGame(String activePlayer, int index) {
    if (activePlayer == Player.x) {
      Player.playerX.add(index);
    } else {
      Player.playerO.add(index);
    }
  }

  String checkWinner() {
    String winner = '';
    List<List<int>> winnerIndexs = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var index in winnerIndexs) {
      if (Player.playerX.containsAll(index)) {
        winner = Player.x;
        Player.playerXWin++;
      } else if (Player.playerO.containsAll(index)) {
        winner = Player.o;
        Player.playerOWin++;
      }
    }
    return winner;
  }
}

extension ContainsAll on List {
  bool containsAll(List<int> indices) {
    for (var index in indices) {
      if (!contains(index)) {
        return false;
      }
    }
    return true;
  }
}
