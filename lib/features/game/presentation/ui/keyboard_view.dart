import 'package:flutter/material.dart';
import 'package:four_words_game/core/extensions/context_x.dart';

class KeyboardView extends StatelessWidget {
  final ValueChanged<String>? onKeyPressed;
  final VoidCallback? onEnterPressed;
  final VoidCallback? onDeletePressed;

  const KeyboardView({super.key, this.onKeyPressed, this.onEnterPressed, this.onDeletePressed});

  final String firstRow = "Q,W,E,R,T,Y,U,I,O,P";
  final String secondRow = "A,S,D,F,G,H,J,K,L";
  final String thirdRow = "Z,X,C,V,B,N,M";

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        Row(
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.center,
          children: firstRow.split(',').map((letter) => _KeyboardLetterView(letter, onPressed: onKeyPressed)).toList(),
        ),
        Row(
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.center,
          children: secondRow.split(',').map((letter) => _KeyboardLetterView(letter, onPressed: onKeyPressed)).toList(),
        ),
        Row(
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _KeyboardLetterView("Del", onPressed: (_) => onDeletePressed?.call()),
            ...thirdRow.split(',').map((letter) => _KeyboardLetterView(letter, onPressed: onKeyPressed)),
            _KeyboardLetterView("Enter", onPressed: (_) => onEnterPressed?.call()),
          ],
        ),
      ],
    );
  }
}

class _KeyboardLetterView extends StatelessWidget {
  final String letter;
  final ValueChanged<String>? _onPressed;

  const _KeyboardLetterView(this.letter, {ValueChanged<String>? onPressed}) : _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onPressed?.call(letter),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.onPrimary),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Text(letter, style: context.textTheme.titleMedium),
      ),
    );
  }
}
