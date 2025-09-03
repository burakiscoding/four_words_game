import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_words_game/core/db/db_client.dart';
import 'package:four_words_game/core/error/exceptions.dart';
import 'package:four_words_game/features/game/data/models/word_card_model.dart';

abstract class GameLocalDataSource {
  Future<WordCardModel> getNextWord();
  Future<void> setWordCompleted(int id);
  Future<int> resetWordCards();
}

class GameLocalDataSourceImpl extends GameLocalDataSource {
  final DbClient _dbClient;

  GameLocalDataSourceImpl(this._dbClient);

  @override
  Future<WordCardModel> getNextWord() async {
    final db = await _dbClient.db;
    final response = await db.query('word_cards', where: 'isCompleted = ?', whereArgs: [0], limit: 1);

    // All words are completed, game over
    if (response.isEmpty) {
      throw WordNotFoundException();
    }

    return WordCardModel.fromMap(response[0]);
  }

  @override
  Future<void> setWordCompleted(int id) async {
    final db = await _dbClient.db;
    await db.update('word_cards', {'isCompleted': 1}, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<int> resetWordCards() async {
    final db = await _dbClient.db;
    return await db.update('word_cards', {'isCompleted': 0});
  }
}

final gameLocalDataSourceProvider = Provider<GameLocalDataSource>((ref) {
  return GameLocalDataSourceImpl(ref.watch(dbClientProvider));
});
