import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_words_game/core/error/failures.dart';
import 'package:four_words_game/core/models/either.dart';
import 'package:four_words_game/features/game/data/repositories/game_repository_impl.dart';
import 'package:four_words_game/features/game/domain/repositories/game_repository.dart';
import 'package:four_words_game/features/history/data/repositories/history_repository_impl.dart';
import 'package:four_words_game/features/history/domain/repositories/history_repository.dart';

class ClearProgressUseCase {
  final HistoryRepository _historyRepository;
  final GameRepository _gameRepository;

  const ClearProgressUseCase({required HistoryRepository historyRepository, required GameRepository gameRepository})
    : _historyRepository = historyRepository,
      _gameRepository = gameRepository;

  Future<Either<Failure, int>> execute() async {
    final result = await _historyRepository.clearHistory();
    await _gameRepository.resetWordCards();
    return result;
  }
}

final clearProgressUseCaseProvider = Provider((ref) {
  return ClearProgressUseCase(
    historyRepository: ref.watch(historyRepositoryProvider),
    gameRepository: ref.watch(gameRepositoryProvider),
  );
});
