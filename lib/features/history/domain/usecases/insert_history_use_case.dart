import 'package:four_words_game/features/history/data/repositories/history_repository_impl.dart';
import 'package:four_words_game/features/history/domain/repositories/history_repository.dart';
import 'package:riverpod/riverpod.dart';

class InsertHistoryUseCase {
  final HistoryRepository _historyRepository;

  const InsertHistoryUseCase({required HistoryRepository historyRepository}) : _historyRepository = historyRepository;

  Future<void> execute(int wordId, List<String> attempts) async {
    return await _historyRepository.insertHistory(wordId, attempts);
  }
}

final insertHistoryUseCaseProvider = Provider<InsertHistoryUseCase>((ref) {
  return InsertHistoryUseCase(historyRepository: ref.watch(historyRepositoryProvider));
});
