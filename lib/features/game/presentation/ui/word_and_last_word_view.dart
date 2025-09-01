import 'package:flutter/material.dart';
import 'package:four_words_game/core/extensions/context_x.dart';
import 'package:four_words_game/core/theme/app_themes.dart';
import 'package:four_words_game/features/game/presentation/models/letter.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WordAndLastWordView extends StatelessWidget {
  final WordString word;
  final Word lastWord;
  final bool isWin;
  final int remainingSeconds;

  const WordAndLastWordView({
    super.key,
    required this.word,
    required this.lastWord,
    required this.isWin,
    required this.remainingSeconds,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50, child: LastWordText(lastWord)),
        const SizedBox(height: 24),
        SizedBox(height: 60, child: _WordText(word, isWin, remainingSeconds)),
      ],
    );
  }
}

class LastWordText extends StatelessWidget {
  final Word word;

  const LastWordText(this.word, {super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      key: ValueKey<String>(word.map((e) => e.value).join('')),
      effects: [FadeEffect(duration: const Duration(milliseconds: 200))],
      child: Row(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: word.map((letter) => LastWordChar(letter)).toList(),
      ),
    );
  }
}

class _WordText extends StatelessWidget {
  final WordString word;
  final bool isWin;
  final int remaniningSeconds;

  const _WordText(this.word, this.isWin, this.remaniningSeconds);

  @override
  Widget build(BuildContext context) {
    if (isWin) {
      return Column(
        children: [
          Text(
            "You Won!",
            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 2),
            textAlign: TextAlign.center,
          ),
          Text("Next word in $remaniningSeconds", style: context.textTheme.titleSmall),
        ],
      );
    } else {
      return Row(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: word.map((letter) => _WordChar(letter)).toList(),
      );
    }
  }
}

class _WordChar extends StatelessWidget {
  final String letter;

  const _WordChar(this.letter);

  @override
  Widget build(BuildContext context) {
    if (letter == "") {
      return _Line();
    }

    return SizedBox(
      width: 25,
      child: Text(
        letter,
        style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class LastWordChar extends StatelessWidget {
  final Letter letter;

  const LastWordChar(this.letter, {super.key});

  Color _colorForState(LetterState state, BuildContext context) {
    switch (state) {
      case LetterState.posCorrect:
        return context.gameColors.posCorrectColor;
      case LetterState.posWrong:
        return context.gameColors.posWrongColor;
      case LetterState.notInWord:
        return context.gameColors.notInWordColor;
      case LetterState.none:
        return context.gameColors.notInWordColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (letter.value == "") {
      return _Line();
    }

    return SizedBox(
      width: 25,
      child: Text(
        letter.value,
        style: context.textTheme.titleLarge?.copyWith(
          color: _colorForState(letter.state, context),
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 5,
      decoration: BoxDecoration(
        color: context.colorScheme.onPrimary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
