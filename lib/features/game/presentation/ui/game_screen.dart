import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_words_game/features/game/presentation/state/game_notifier.dart';
import 'package:four_words_game/features/game/presentation/ui/end_of_game_screen.dart';
import 'package:four_words_game/features/game/presentation/ui/keyboard_view.dart';
import 'package:four_words_game/features/game/presentation/ui/keywords_view.dart';
import 'package:four_words_game/features/game/presentation/ui/word_and_last_word_view.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(gameProvider);

    if (state.isWordsOver) {
      return EndOfGameScreen(onPop: _pop);
    }

    if (state.errorMessage != null) {
      return Center(child: Text(state.errorMessage!));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Three Words Game')),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            KeywordsView(keywords: state.wordCard.keywords),
            const Spacer(),
            WordAndLastWordView(
              word: state.word,
              lastWord: state.lastWord,
              isWin: state.isWin,
              remainingSeconds: ref.read(gameProvider.notifier).countdownStream,
            ),
            const Spacer(),
            KeyboardView(
              onKeyPressed: ref.read(gameProvider.notifier).updateWord,
              onDeletePressed: ref.read(gameProvider.notifier).deleteWord,
              onEnterPressed: ref.read(gameProvider.notifier).submitWord,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _pop() {
    Navigator.of(context).pop();
  }
}
