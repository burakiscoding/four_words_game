import 'package:four_words_game/core/error/failures.dart';
import 'package:four_words_game/core/models/either.dart';
import 'package:four_words_game/features/history/domain/entities/history_word_entity.dart';

abstract class HistoryRepository {
  Future<Either<Failure, List<HistoryWordEntity>>> getHistory();
  Future<void> insertHistory(int wordId, List<String> attempts);
}
