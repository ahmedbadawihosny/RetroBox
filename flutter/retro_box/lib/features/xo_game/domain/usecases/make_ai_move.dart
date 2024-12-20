import 'package:retro_box/features/xo_game/domain/entites/xo_game_entity.dart';
import 'package:retro_box/features/xo_game/domain/repository/xo_game_repository.dart';

class MakeAIMove {
  final XOGameRepository repository;

  MakeAIMove({required this.repository});

  Future<XOGameEntity> call(int position) async {
    return await repository.makeAIMove(position);
  }
}
