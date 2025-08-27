import 'package:four_words_game/core/error/failures.dart';
import 'package:four_words_game/core/models/either.dart';
import 'package:four_words_game/features/game/domain/entities/word_card_entity.dart';

abstract class GameRepository {
  Future<Either<Failure, WordCardEntity>> getWordCard(int id);
}
