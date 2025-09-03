import 'package:four_words_game/features/history/domain/usecases/clear_progress_use_case.dart';
import 'package:four_words_game/features/history/domain/usecases/get_history_use_case.dart';
import 'package:four_words_game/features/history/presentation/state/history_state.dart';
import 'package:riverpod/riverpod.dart';

class HistoryNotifier extends StateNotifier<HistoryState> {
  final GetHistoryUseCase _getHistoryUseCase;
  final ClearProgressUseCase _clearProgressUseCase;
  HistoryNotifier({required GetHistoryUseCase getHistoryUseCase, required ClearProgressUseCase clearProgressUseCase})
    : _getHistoryUseCase = getHistoryUseCase,
      _clearProgressUseCase = clearProgressUseCase,
      super(const HistoryState.initial()) {
    _getHistory();
  }

  Future<void> _getHistory() async {
    final result = await _getHistoryUseCase.execute();
    result.fold((failure) {}, (history) {
      state = state.copyWith(history: history);
    });
  }

  Future<void> clearProgress() async {
    final result = await _clearProgressUseCase.execute();
    result.fold((failure) {}, (count) {
      state = state.copyWith(history: []);
    });
  }
}

final historyProvider = StateNotifierProvider.autoDispose<HistoryNotifier, HistoryState>((ref) {
  return HistoryNotifier(
    getHistoryUseCase: ref.watch(getHistoryUseCaseProvider),
    clearProgressUseCase: ref.watch(clearProgressUseCaseProvider),
  );
});
