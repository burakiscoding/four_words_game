import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_words_game/core/db/db_seed_service.dart';
import 'package:four_words_game/features/game/presentation/ui/end_of_game_screen.dart';
import 'package:four_words_game/features/game/presentation/ui/game_screen.dart';
import 'package:four_words_game/features/history/presentation/ui/history_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  await container.read(dbSeedServiceProvider).insertWordCards();

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Four Words Game',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const EndOfGameScreen(),
    );
  }
}
