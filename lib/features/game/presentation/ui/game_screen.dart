import 'package:flutter/material.dart';
import 'package:four_words_game/features/game/presentation/ui/keyboard_view.dart';
import 'package:four_words_game/features/game/presentation/ui/keywords_view.dart';
import 'package:four_words_game/features/game/presentation/ui/word_input_view.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            KeywordsView(keywords: ["Teacher", "Student", "Learning", "Books"]),
            Spacer(),
            WordInputView(word: ["S", "C", "H", "O", "O", "L"], lastWord: ["M", "A", "N", "A", "G", "E"]),
            Spacer(),
            KeyboardView(),
          ],
        ),
      ),
    );
  }
}
