import 'package:retro_box/features/xo_game/domain/entites/xo_game_entity.dart';

abstract class XOGameRepository {
  Future<XOGameEntity> makeAIMove(int position);
  Future<XOGameEntity> resetGame();
}
