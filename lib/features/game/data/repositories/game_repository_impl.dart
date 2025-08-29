import 'package:four_words_game/core/error/exceptions.dart';
import 'package:four_words_game/core/error/failures.dart';
import 'package:four_words_game/core/models/either.dart';
import 'package:four_words_game/features/game/data/datasources/game_local_data_source.dart';
import 'package:four_words_game/features/game/data/models/word_card_model.dart';
import 'package:four_words_game/features/game/domain/entities/word_card_entity.dart';
import 'package:four_words_game/features/game/domain/repositories/game_repository.dart';
import 'package:riverpod/riverpod.dart';

class GameRepositoryImpl extends GameRepository {
  final GameLocalDataSource _localDataSource;

  GameRepositoryImpl({required GameLocalDataSource localDataSource}) : _localDataSource = localDataSource;

  @override
  Future<Either<Failure, WordCardEntity>> getNextWord() async {
    try {
      final response = await _localDataSource.getNextWord();
      return Right(response.toEntity());
    } on WordNotFoundException catch (_) {
      return Left(const WordNotFoundFailure());
    } catch (e) {
      return Left(const UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<WordCardEntity>>> getCompletedWords() async {
    try {
      final response = await _localDataSource.getCompletedWords();
      return Right(response.map((e) => e.toEntity()).toList());
    } on WordNotFoundException catch (_) {
      return Left(const WordNotFoundFailure());
    } catch (e) {
      return Left(const UnknownFailure());
    }
  }

  @override
  Future<void> setWordCompleted(int id) async {
    try {
      await _localDataSource.setWordCompleted(id);
    } catch (_) {}
  }
}

final gameRepositoryProvider = Provider<GameRepository>((ref) {
  return GameRepositoryImpl(localDataSource: ref.watch(gameLocalDataSourceProvider));
});
