import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_words_game/core/error/failures.dart';
import 'package:four_words_game/features/game/domain/usecases/get_next_word_use_case.dart';
import 'package:four_words_game/features/game/domain/usecases/set_word_completed_use_case.dart';
import 'package:four_words_game/features/game/presentation/helpers/game_helper.dart';
import 'package:four_words_game/features/game/presentation/state/game_state.dart';
import 'package:four_words_game/features/history/domain/usecases/insert_history_use_case.dart';

class GameNotifier extends StateNotifier<GameState> {
  final GameHelper _gameHelper;
  final GetNextWordUseCase _getNextWordUseCase;
  final SetWordCompletedUseCase _setWordCompletedUseCase;
  final InsertHistoryUseCase _insertHistoryUseCase;

  GameNotifier({
    required GameHelper gameHelper,
    required GetNextWordUseCase getNextWordUseCase,
    required SetWordCompletedUseCase setWordCompletedUseCase,
    required InsertHistoryUseCase insertHistoryUseCase,
  }) : _gameHelper = gameHelper,
       _getNextWordUseCase = getNextWordUseCase,
       _setWordCompletedUseCase = setWordCompletedUseCase,
       _insertHistoryUseCase = insertHistoryUseCase,
       super(const GameState.initial());

  Timer? _timer;

  void cancelTimer() {
    _timer?.cancel();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds > 1) {
        state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
      } else {
        cancelTimer();
        getWordCard();
      }
    });
  }

  Future<void> getWordCard() async {
    final result = await _getNextWordUseCase.execute();

    result.fold(
      (failure) {
        // Handle failure
        if (failure is WordNotFoundFailure) {
          state = state.copyWith(isWordsOver: true);
        } else {
          state = state.copyWith(errorMessage: failure.message);
        }
      },
      (wordCard) {
        final word = _gameHelper.createEmptyWordString(wordCard.word.length);
        final lastWord = _gameHelper.createEmptyWord(wordCard.word.length);

        state = state.copyWith(
          wordCard: wordCard,
          word: word,
          lastWord: lastWord,
          isWin: false,
          remainingSeconds: 5,
          errorMessage: null,
        );
      },
    );
  }

  void updateWord(String s) {
    final word = state.word;
    final index = state.index;

    if (index < word.length) {
      word[index] = s;
      state = state.copyWith(word: word, index: index + 1);
    }
  }

  void deleteWord() {
    final word = state.word;
    final index = state.index;

    if (index > 0) {
      word[index - 1] = "";
      state = state.copyWith(word: word, index: index - 1);
    }
  }

  void submitWord() async {
    if (!_gameHelper.canSubmit(state.word)) {
      return;
    }
    // Check if user won
    if (_gameHelper.isWordStringCorrect(state.word, state.wordCard.word)) {
      final lastWord = _gameHelper.createCorrectWord(state.wordCard.word);
      final emptyWord = _gameHelper.createEmptyWordString(state.wordCard.word.length);
      state = state.copyWith(word: emptyWord, lastWord: lastWord, index: 0, isWin: true);

      // 5 seconds before the next word
      _startTimer();

      await _setWordCompletedUseCase.execute(state.wordCard.id);
      await _insertHistoryUseCase.execute(state.wordCard.id, _gameHelper.attempts);
      _gameHelper.clearAttempts();

      return;
    }

    var secretWord = state.wordCard.word.split('');
    var word = state.word;
    var lastWord = _gameHelper.createWordFromWordString(word);

    // Add attempt
    _gameHelper.addAttempt(word.join(''));

    // Check positions
    lastWord = _gameHelper.checkPositions(word, lastWord, secretWord);

    // Reset word and update last word
    final emptyWord = _gameHelper.createEmptyWordString(state.wordCard.word.length);
    state = state.copyWith(word: emptyWord, lastWord: lastWord, index: 0);
  }
}

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  return GameNotifier(
    gameHelper: ref.watch(gameHelperProvider),
    getNextWordUseCase: ref.watch(getNextWordUseCaseProvider),
    setWordCompletedUseCase: ref.watch(setWordCompletedProvider),
    insertHistoryUseCase: ref.watch(insertHistoryUseCaseProvider),
  );
});
