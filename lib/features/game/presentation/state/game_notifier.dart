import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_words_game/features/game/domain/entities/word_card_entity.dart';
import 'package:four_words_game/features/game/presentation/helpers/game_helper.dart';
import 'package:four_words_game/features/game/presentation/state/game_state.dart';

class GameNotifier extends StateNotifier<GameState> {
  final GameHelper _gameHelper;

  GameNotifier({required GameHelper gameHelper}) : _gameHelper = gameHelper, super(const GameState.initial());

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
    final wordCard = WordCardEntity.example();
    final word = _gameHelper.createEmptyWordString(wordCard.word.length);
    final lastWord = _gameHelper.createEmptyWord(wordCard.word.length);

    state = state.copyWith(wordCard: wordCard, word: word, lastWord: lastWord, isWin: false, remainingSeconds: 5);
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

  void submitWord() {
    // Check if user won
    if (_gameHelper.isWordStringCorrect(state.word, state.wordCard.word)) {
      final lastWord = _gameHelper.createCorrectWord(state.wordCard.word);
      final emptyWord = _gameHelper.createEmptyWordString(state.wordCard.word.length);
      state = state.copyWith(word: emptyWord, lastWord: lastWord, index: 0, isWin: true);

      // _startTimer();

      return;
    }

    var secretWord = state.wordCard.word.split('');
    var word = state.word;
    var lastWord = _gameHelper.createWordFromWordString(word);

    // Check positions
    lastWord = _gameHelper.checkPositions(word, lastWord, secretWord);

    final emptyWord = _gameHelper.createEmptyWordString(state.wordCard.word.length);
    state = state.copyWith(word: emptyWord, lastWord: lastWord, index: 0);
  }
}

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  final gameHelper = ref.watch(gameHelperProvider);

  return GameNotifier(gameHelper: gameHelper);
});
