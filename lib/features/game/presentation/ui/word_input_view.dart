import 'package:flutter/material.dart';

class WordInputView extends StatelessWidget {
  final List<String> word;
  final List<String> lastWord;

  const WordInputView({super.key, required this.word, required this.lastWord});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _WordInputHistoryView(lastWord),
        const SizedBox(height: 32),
        Row(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: word.map((letter) => _WordInputLetterView(letter)).toList(),
        ),
      ],
    );
  }
}

class _WordInputLetterView extends StatelessWidget {
  final String letter;

  const _WordInputLetterView(this.letter);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 5,
      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(4))),
    );
  }
}

class _WordInputHistoryView extends StatelessWidget {
  final List<String> lastWord;

  const _WordInputHistoryView(this.lastWord);

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      mainAxisAlignment: MainAxisAlignment.center,
      children: lastWord
          .map(
            (t) => SizedBox(
              width: 20,
              child: Text(t, style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center),
            ),
          )
          .toList(),
    );
  }
}
