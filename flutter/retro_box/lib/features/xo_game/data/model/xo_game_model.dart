import 'package:retro_box/features/xo_game/domain/entites/xo_game_entity.dart';

class XoGameModel extends XOGameEntity {
  const XoGameModel({
    required super.board,
    required super.winner,
  });

  factory XoGameModel.fromJson(Map<String, dynamic> json) {
    return XoGameModel(
      board: List<String>.from(json['board']),
      winner: json['winner'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'board': board,
      'winner': winner,
    };
  }
}
