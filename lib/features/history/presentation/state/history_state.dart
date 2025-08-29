import 'package:four_words_game/features/history/domain/entities/history_word_entity.dart';

class HistoryState {
  final List<HistoryWordEntity> history;

  const HistoryState({required this.history});

  const HistoryState.initial({this.history = const []});

  HistoryState copyWith({List<HistoryWordEntity>? history}) {
    return HistoryState(history: history ?? this.history);
  }
}
