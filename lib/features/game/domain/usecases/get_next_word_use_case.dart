import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_words_game/core/error/failures.dart';
import 'package:four_words_game/core/models/either.dart';
import 'package:four_words_game/features/game/data/repositories/game_repository_impl.dart';
import 'package:four_words_game/features/game/domain/entities/word_card_entity.dart';
import 'package:four_words_game/features/game/domain/repositories/game_repository.dart';

class GetNextWordUseCase {
  final GameRepository _gameRepository;

  GetNextWordUseCase({required GameRepository gameRepository}) : _gameRepository = gameRepository;

  Future<Either<Failure, WordCardEntity>> execute() async {
    return await _gameRepository.getNextWord();
  }
}

final getNextWordUseCaseProvider = Provider<GetNextWordUseCase>((ref) {
  return GetNextWordUseCase(gameRepository: ref.watch(gameRepositoryProvider));
});
