import 'package:retro_box/features/xo_game/domain/entites/xo_game_entity.dart';
import 'package:retro_box/features/xo_game/domain/repository/xo_game_repository.dart';

class ResetGame {
  final XOGameRepository repository;

  ResetGame({required this.repository});

  Future<XOGameEntity> call() async {
    return await repository.resetGame();
  }
}
