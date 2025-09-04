import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_words_game/core/error/failures.dart';
import 'package:four_words_game/core/models/either.dart';
import 'package:four_words_game/features/game/domain/entities/word_card_entity.dart';
import 'package:four_words_game/features/game/domain/usecases/get_next_word_use_case.dart';
import 'package:four_words_game/features/game/domain/usecases/set_word_completed_use_case.dart';
import 'package:four_words_game/features/game/presentation/helpers/countdown_helper.dart';
import 'package:four_words_game/features/game/presentation/helpers/game_helper.dart';
import 'package:four_words_game/features/game/presentation/state/game_state.dart';
import 'package:four_words_game/features/history/domain/usecases/insert_history_use_case.dart';

class GameNotifier extends StateNotifier<GameState> {
  final GameHelper _gameHelper;
  final GetNextWordUseCase _getNextWordUseCase;
  final SetWordCompletedUseCase _setWordCompletedUseCase;
  final InsertHistoryUseCase _insertHistoryUseCase;
  final CountdownHelper _countdownHelper;

  GameNotifier({
    required GameHelper gameHelper,
    required GetNextWordUseCase getNextWordUseCase,
    required SetWordCompletedUseCase setWordCompletedUseCase,
    required InsertHistoryUseCase insertHistoryUseCase,
    required CountdownHelper countdownHelper,
  }) : _gameHelper = gameHelper,
       _getNextWordUseCase = getNextWordUseCase,
       _setWordCompletedUseCase = setWordCompletedUseCase,
       _insertHistoryUseCase = insertHistoryUseCase,
       _countdownHelper = countdownHelper,
       super(const GameState.initial()) {
    _getAndSetNewWord();
  }

  Stream<int> get countdownStream => _countdownHelper.stream;

  @override
  void dispose() {
    _countdownHelper.dispose();
    super.dispose();
  }

  void _handleError(Failure failure) {
    if (!mounted) {
      return;
    }

    if (failure is WordNotFoundFailure) {
      state = state.copyWith(isWordsOver: true, isLoading: false);
    } else {
      state = state.copyWith(errorMessage: failure.message, isLoading: false);
    }
  }

  Future<Either<Failure, WordCardEntity>> _getNewWord() async {
    return await _getNextWordUseCase.execute();
  }

  void _setNewWord(WordCardEntity wordCard) {
    if (!mounted) {
      return;
    }

    final word = _gameHelper.createEmptyWordString(wordCard.word.length);
    final lastWord = _gameHelper.createEmptyWord(wordCard.word.length);

    state = state.copyWith(
      wordCard: wordCard,
      word: word,
      lastWord: lastWord,
      isWin: false,
      errorMessage: null,
      index: 0,
      isLoading: false,
    );
  }

  Future<void> _getAndSetNewWord() async {
    final result = await _getNewWord();
    result.fold(_handleError, _setNewWord);
  }

  Future<Either<Failure, WordCardEntity>> _completeWordAndGetNewOne() async {
    await _setWordCompletedUseCase.execute(state.wordCard.id);
    await _insertHistoryUseCase.execute(state.wordCard.id, _gameHelper.attempts);
    _gameHelper.clearAttempts();
    return await _getNewWord();
  }

  void updateWord(String s) {
    if (state.isLoading) {
      return;
    }

    final word = state.word;
    final index = state.index;

    if (index < word.length) {
      word[index] = s;
      state = state.copyWith(word: word, index: index + 1);
    }
  }

  void deleteWord() {
    if (state.isLoading) {
      return;
    }

    final word = state.word;
    final index = state.index;

    if (index > 0) {
      word[index - 1] = "";
      state = state.copyWith(word: word, index: index - 1);
    }
  }

  void submitWord() async {
    if (!_gameHelper.canSubmit(state.word) || state.isLoading) {
      return;
    }

    // Check if user won
    if (_gameHelper.isWordStringCorrect(state.word, state.wordCard.word)) {
      final lastWord = _gameHelper.createCorrectWord(state.wordCard.word);
      final emptyWord = _gameHelper.createEmptyWordString(state.wordCard.word.length);
      state = state.copyWith(word: emptyWord, lastWord: lastWord, index: 0, isWin: true, isLoading: true);

      // Get a new word and start 5 seconds countdown at the same time
      // After 5 seconds show the new word
      final result = await _countdownHelper.start(_completeWordAndGetNewOne);
      result.fold(_handleError, _setNewWord);

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

final gameProvider = StateNotifierProvider.autoDispose<GameNotifier, GameState>((ref) {
  return GameNotifier(
    gameHelper: ref.watch(gameHelperProvider),
    getNextWordUseCase: ref.watch(getNextWordUseCaseProvider),
    setWordCompletedUseCase: ref.watch(setWordCompletedProvider),
    insertHistoryUseCase: ref.watch(insertHistoryUseCaseProvider),
    countdownHelper: ref.watch(countdownHelperProvider(5)),
  );
});
