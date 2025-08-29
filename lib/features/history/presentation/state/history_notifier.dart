import 'package:four_words_game/features/history/domain/usecases/get_history_use_case.dart';
import 'package:four_words_game/features/history/presentation/state/history_state.dart';
import 'package:riverpod/riverpod.dart';

class HistoryNotifier extends StateNotifier<HistoryState> {
  final GetHistoryUseCase _getHistoryUseCase;
  HistoryNotifier({required GetHistoryUseCase getHistoryUseCase})
    : _getHistoryUseCase = getHistoryUseCase,
      super(const HistoryState.initial());

  Future<void> getHistory() async {
    final result = await _getHistoryUseCase.execute();
    result.fold((failure) {}, (history) {
      state = state.copyWith(history: history);
    });
  }
}

final historyProvider = StateNotifierProvider<HistoryNotifier, HistoryState>((ref) {
  return HistoryNotifier(getHistoryUseCase: ref.watch(getHistoryUseCaseProvider));
});
