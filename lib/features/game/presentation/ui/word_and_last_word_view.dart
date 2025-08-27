import 'package:flutter/material.dart';
import 'package:four_words_game/features/game/presentation/models/letter.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WordAndLastWordView extends StatelessWidget {
  final WordString word;
  final Word lastWord;
  final bool isWin;

  const WordAndLastWordView({super.key, required this.word, required this.lastWord, required this.isWin});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50, child: _LastWordText(lastWord)),
        const SizedBox(height: 24),
        SizedBox(height: 60, child: _WordText(word, isWin)),
      ],
    );
  }
}

class _LastWordText extends StatelessWidget {
  final Word word;

  const _LastWordText(this.word);

  @override
  Widget build(BuildContext context) {
    return Animate(
      key: ValueKey<String>(word.map((e) => e.value).join('')),
      effects: [
        // SlideEffect(
        //   begin: Offset(0, 0.9),
        //   end: Offset(0, 0),
        //   curve: Curves.easeOut,
        //   duration: Duration(milliseconds: 500),
        // ),
        FadeEffect(duration: const Duration(milliseconds: 200)),
      ],
      child: Row(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: word.map((letter) => _LastWordChar(letter)).toList(),
      ),
    );
  }
}

class _WordText extends StatelessWidget {
  final WordString word;
  final bool isWin;

  const _WordText(this.word, this.isWin);

  @override
  Widget build(BuildContext context) {
    if (isWin) {
      return Column(
        children: [
          Text(
            "You Won!",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Color.fromRGBO(83, 70, 52, 1),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
            textAlign: TextAlign.center,
          ),
          Text("Next word in 3", style: Theme.of(context).textTheme.titleSmall),
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
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(color: Color.fromRGBO(83, 70, 52, 1), fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _LastWordChar extends StatelessWidget {
  final Letter letter;

  const _LastWordChar(this.letter);

  Color _colorForState(LetterState state) {
    switch (state) {
      case LetterState.posCorrect:
        return Colors.green;
      case LetterState.posWrong:
        return Colors.orange;
      case LetterState.notInWord:
        return Color.fromRGBO(83, 70, 52, 1);
      case LetterState.none:
        return Color.fromRGBO(83, 70, 52, 1);
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
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(color: _colorForState(letter.state), fontWeight: FontWeight.bold),
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
        color: Color.fromRGBO(83, 70, 52, 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
