import 'package:flutter/material.dart';
import 'package:four_words_game/features/game/presentation/ui/game_screen.dart';
import 'package:four_words_game/features/history/presentation/ui/history_screen.dart';
import 'package:four_words_game/features/menu/presentation/ui/menu_button.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFFFF2E0),
      backgroundColor: Color(0xFFFFF2EB),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "THREE WORDS\nGAME",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(fontFamily: 'PermanentMarker'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    MenuButton(onPressed: _pushGameScreen, text: 'PLAY'),
                    const SizedBox(height: 24),
                    MenuButton(onPressed: _pushHistoryScreen, text: 'HISTORY'),
                    const SizedBox(height: 24),
                    MenuButton(onPressed: _pushHowToPlayScreen, text: 'HOW TO PLAY?'),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pushGameScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => GameScreen()));
  }

  void _pushHistoryScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => HistoryScreen()));
  }

  void _pushHowToPlayScreen() {}
}
