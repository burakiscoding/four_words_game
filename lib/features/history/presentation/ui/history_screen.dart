import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_words_game/core/extensions/context_x.dart';
import 'package:four_words_game/core/theme/app_themes.dart';
import 'package:four_words_game/features/history/presentation/state/history_notifier.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(historyProvider.notifier).getHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(historyProvider);

    return Scaffold(
      appBar: AppBar(title: Text("History")),
      body: ListView.builder(
        itemCount: state.history.length,
        itemBuilder: (context, index) {
          final item = state.history[index];

          return ListTile(
            leading: CircleAvatar(child: Text(item.id.toString())),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(item.word, style: context.textTheme.titleMedium),
                Text(item.keywords.join(','), style: context.textTheme.titleMedium),
              ],
            ),
            subtitle: RichText(
              text: TextSpan(
                children: [
                  ...item.attempts.map((e) => TextSpan(text: "$e, ", style: context.textTheme.titleSmall)),
                  TextSpan(
                    text: item.word,
                    style: context.textTheme.titleSmall?.copyWith(color: AppColors.green, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
