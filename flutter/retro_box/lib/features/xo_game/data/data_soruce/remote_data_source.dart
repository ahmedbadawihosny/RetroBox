import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:retro_box/features/xo_game/data/model/xo_game_model.dart';
import 'package:retro_box/features/xo_game/domain/entites/xo_game_entity.dart';

abstract class RemoteDataSource {
  Future<XOGameEntity> makeAIMove(int position);
  Future<XOGameEntity> resetGame();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final String baseUrl = 'https://retrobox-api.vercel.app/xo';

  @override
  Future<XOGameEntity> makeAIMove(int position) async {
    final response =
        await http.get(Uri.parse('$baseUrl/move?position=$position'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return XoGameModel.fromJson(data);
    } else {
      throw Exception('Failed to make AI move');
    }
  }

  @override
  Future<XOGameEntity> resetGame() async {
    final response = await http.get(Uri.parse('$baseUrl/reset'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return XoGameModel.fromJson(data);
    } else {
      throw Exception('Failed to reset game');
    }
  }
}
