import 'package:four_words_game/core/db/db_client.dart';
import 'package:four_words_game/features/game/data/models/word_card_model.dart';

abstract class GameLocalDataSource {
  Future<WordCardModel> getWordCard(int id);
}

class GameLocalDataSourceImpl extends GameLocalDataSource {
  final DbClient _dbClient;

  GameLocalDataSourceImpl(this._dbClient);

  @override
  Future<WordCardModel> getWordCard(int id) {
    // call db

    final response = WordCardModel(
      id: 1,
      word: "school",
      keywords: ["Teacher", "Student", "Homework"],
      isCompleted: false,
    );

    return Future.value(response);
  }
}
