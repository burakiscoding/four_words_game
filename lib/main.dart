import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_words_game/core/db/db_seed_service.dart';
import 'package:four_words_game/core/theme/app_themes.dart';
import 'package:four_words_game/features/menu/presentation/ui/menu_screen.dart';
import 'package:four_words_game/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase Init
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Firebase Crashlytics Error Handle
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // Riverpod Container
  final container = ProviderContainer();

  // Database Seed
  await container.read(dbSeedServiceProvider).insertWordCards();

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Four Words Game',
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      home: const MenuScreen(),
    );
  }
}
