import 'package:flutter/material.dart';

class KeyboardView extends StatelessWidget {
  const KeyboardView({super.key});

  final String firstRow = "Q,W,E,R,T,Y,U,I,O,P";
  final String secondRow = "A,S,D,F,G,H,J,K,L";
  final String thirdRow = "Del,Z,X,C,V,B,N,M,Enter";

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        Row(
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.center,
          children: firstRow.split(',').map((letter) => _KeyboardLetterView(letter)).toList(),
        ),
        Row(
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.center,
          children: secondRow.split(',').map((letter) => _KeyboardLetterView(letter)).toList(),
        ),
        Row(
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.center,
          children: thirdRow.split(',').map((letter) => _KeyboardLetterView(letter)).toList(),
        ),
      ],
    );
  }
}

class _KeyboardLetterView extends StatelessWidget {
  final String letter;

  const _KeyboardLetterView(this.letter);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey,
      child: Text(letter, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
