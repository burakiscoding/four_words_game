import 'package:four_words_game/core/error/failures.dart';
import 'package:four_words_game/core/models/either.dart';
import 'package:four_words_game/features/history/data/repositories/history_repository_impl.dart';
import 'package:four_words_game/features/history/domain/entities/history_word_entity.dart';
import 'package:four_words_game/features/history/domain/repositories/history_repository.dart';
import 'package:riverpod/riverpod.dart';

class GetHistoryUseCase {
  final HistoryRepository _historyRepository;

  GetHistoryUseCase({required HistoryRepository historyRepository}) : _historyRepository = historyRepository;

  Future<Either<Failure, List<HistoryWordEntity>>> execute() async {
    return await _historyRepository.getHistory();
  }
}

final getHistoryUseCaseProvider = Provider<GetHistoryUseCase>((ref) {
  return GetHistoryUseCase(historyRepository: ref.watch(historyRepositoryProvider));
});
