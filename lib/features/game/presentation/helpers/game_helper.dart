import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_words_game/features/game/presentation/models/letter.dart';

class GameHelper {
  final List<String> _attempts = [];
  // We only save last 10 attempts!
  List<String> get attempts => _attempts.reversed.take(10).toList().reversed.toList();

  void addAttempt(String word) {
    _attempts.add(word);
  }

  void clearAttempts() {
    _attempts.clear();
  }

  Word createEmptyWord(int n) {
    return List.filled(n, const Letter.empty());
  }

  WordString createEmptyWordString(int n) {
    return List.filled(n, "");
  }

  bool isWordStringCorrect(WordString word, String secretWord) {
    return word.join('') == secretWord;
  }

  Word createWordFromWordString(WordString wordString) {
    return wordString.map((letter) => Letter(value: letter, state: LetterState.none)).toList();
  }

  Word createCorrectWord(String secretWord) {
    final correctWord = createEmptyWord(secretWord.length);

    for (int i = 0; i < secretWord.length; i++) {
      correctWord[i] = Letter(value: secretWord[i], state: LetterState.posCorrect);
    }

    return correctWord;
  }

  (Word, WordString) _checkCorrectPositions(WordString word, Word lastWord, WordString secretWord) {
    for (int i = 0; i < secretWord.length; i++) {
      if (word[i] == secretWord[i]) {
        lastWord[i] = Letter(value: word[i], state: LetterState.posCorrect);
        secretWord[i] = "*";
      }
    }
    return (lastWord, secretWord);
  }

  Word _checkWrongPositions(WordString word, Word lastWord, WordString secretWord) {
    for (int i = 0; i < secretWord.length; i++) {
      if (lastWord[i].state == LetterState.posCorrect && secretWord[i] == "*") {
        continue;
      }

      final index = secretWord.indexOf(word[i]);
      if (index != -1) {
        lastWord[i] = Letter(value: word[i], state: LetterState.posWrong);
        secretWord[index] = "*";
      } else {
        lastWord[i] = Letter(value: word[i], state: LetterState.notInWord);
      }
    }

    return lastWord;
  }

  Word checkPositions(WordString word, Word lastWord, WordString secretWord) {
    (lastWord, secretWord) = _checkCorrectPositions(word, lastWord, secretWord);
    lastWord = _checkWrongPositions(word, lastWord, secretWord);
    return lastWord;
  }

  bool canSubmit(WordString word) {
    return word.every((e) => e.isNotEmpty);
  }
}

final gameHelperProvider = Provider.autoDispose((ref) {
  return GameHelper();
});
