
import 'package:retro_box/features/xo_game/data/data_soruce/remote_data_source.dart';
import 'package:retro_box/features/xo_game/domain/entites/xo_game_entity.dart';
import 'package:retro_box/features/xo_game/domain/repository/xo_game_repository.dart';

class XoGameRepositoryImpl implements XOGameRepository {
  final RemoteDataSource remoteDataSource;

  XoGameRepositoryImpl(this.remoteDataSource);

  @override
  Future<XOGameEntity> makeAIMove(int position) {
    return remoteDataSource.makeAIMove(position);
  }

  @override
  Future<XOGameEntity> resetGame() {
    return remoteDataSource.resetGame();
  }
}
