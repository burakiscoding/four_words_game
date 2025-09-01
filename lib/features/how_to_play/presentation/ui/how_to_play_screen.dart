import 'package:flutter/material.dart';
import 'package:four_words_game/core/extensions/context_x.dart';
import 'package:four_words_game/features/game/presentation/models/letter.dart';
import 'package:four_words_game/features/game/presentation/ui/keywords_view.dart';
import 'package:four_words_game/features/game/presentation/ui/word_and_last_word_view.dart';

class HowToPlayScreen extends StatefulWidget {
  const HowToPlayScreen({super.key});

  @override
  State<HowToPlayScreen> createState() => _HowToPlayScreenState();
}

class _HowToPlayScreenState extends State<HowToPlayScreen> {
  final Word firstGuess = [
    Letter(value: "T", state: LetterState.notInWord),
    Letter(value: "A", state: LetterState.posWrong),
    Letter(value: "B", state: LetterState.notInWord),
    Letter(value: "L", state: LetterState.posWrong),
    Letter(value: "E", state: LetterState.posCorrect),
  ];
  final Word secondGuess = [
    Letter(value: "F", state: LetterState.posCorrect),
    Letter(value: "L", state: LetterState.posCorrect),
    Letter(value: "A", state: LetterState.posCorrect),
    Letter(value: "S", state: LetterState.notInWord),
    Letter(value: "H", state: LetterState.notInWord),
  ];
  final Word thirdGuess = [
    Letter(value: "F", state: LetterState.posCorrect),
    Letter(value: "L", state: LetterState.posCorrect),
    Letter(value: "A", state: LetterState.posCorrect),
    Letter(value: "M", state: LetterState.posCorrect),
    Letter(value: "E", state: LetterState.posCorrect),
  ];
  final List<String> keywords = ["Fire", "Heat", "Bright"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("How To Play"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.delete))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const _Text(
                "You have to guess the secret word using the keywords and the color of the letters changes to show how close you are.",
              ),
              _DecoratedBox(
                child: Row(
                  children: [
                    _Text("Keywords: "),
                    KeywordsView(keywords: keywords),
                  ],
                ),
              ),
              const _Text("To start the game, just enter any word, for example:"),
              LastWordText(firstGuess),
              _DecoratedBox(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        LastWordChar(firstGuess[0]),
                        _Text(","),
                        LastWordChar(firstGuess[2]),
                        _Text(" aren't in the target word at all."),
                      ],
                    ),
                    Row(
                      children: [
                        LastWordChar(firstGuess[1]),
                        _Text(","),
                        LastWordChar(firstGuess[3]),
                        _Text(" are in the word but in the wrong spot."),
                      ],
                    ),
                    Row(children: [LastWordChar(firstGuess[4]), _Text(" is in the word and in the correct spot.")]),
                  ],
                ),
              ),
              const _Text("Another try to find matching letters in the secret word"),
              LastWordText(secondGuess),
              const _Text("So close"),
              LastWordText(thirdGuess),
              Text(
                "Got it 🏆",
                style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  final String text;
  const _Text(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: TextAlign.center, style: context.textTheme.bodyLarge);
  }
}

class _DecoratedBox extends StatelessWidget {
  final Widget child;
  const _DecoratedBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: context.theme.cardColor, borderRadius: BorderRadius.circular(4)),
      child: Padding(padding: const EdgeInsets.all(8), child: child),
    );
  }
}
