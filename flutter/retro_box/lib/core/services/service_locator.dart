import 'package:get_it/get_it.dart';
import 'package:retro_box/core/database/cache/cache_helper.dart';
import 'package:retro_box/features/xo_game/data/data_soruce/remote_data_source.dart';
import 'package:retro_box/features/xo_game/data/repository/xo_game_repository_impl.dart';
import 'package:retro_box/features/xo_game/domain/repository/xo_game_repository.dart';
import 'package:retro_box/features/xo_game/domain/usecases/make_ai_move.dart';
import 'package:retro_box/features/xo_game/domain/usecases/reset_game.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Cahce Helper
  getIt.registerSingleton<CacheHelper>(CacheHelper());

  // XO Game
  getIt.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());
  getIt.registerLazySingleton<XOGameRepository>(
    () => XoGameRepositoryImpl(getIt<RemoteDataSource>()),
  );
  getIt.registerLazySingleton(() => MakeAIMove(repository: getIt<XOGameRepository>()));
  getIt.registerLazySingleton(() => ResetGame(repository: getIt<XOGameRepository>()));
}