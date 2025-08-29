import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_words_game/features/game/data/repositories/game_repository_impl.dart';
import 'package:four_words_game/features/game/domain/repositories/game_repository.dart';

class SetWordCompletedUseCase {
  final GameRepository _gameRepository;

  SetWordCompletedUseCase({required GameRepository gameRepository}) : _gameRepository = gameRepository;

  Future<void> execute(int id) async {
    return await _gameRepository.setWordCompleted(id);
  }
}

final setWordCompletedProvider = Provider<SetWordCompletedUseCase>((ref) {
  return SetWordCompletedUseCase(gameRepository: ref.watch(gameRepositoryProvider));
});
