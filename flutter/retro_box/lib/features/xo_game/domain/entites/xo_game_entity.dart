class XOGameEntity {
  final List<String> board;
  final String winner;

  const XOGameEntity({
    required this.board,
    this.winner = '',
  });

  bool get isDraw => !board.contains(' ') && winner.isEmpty;
}

