import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:four_words_game/core/extensions/context_x.dart';
import 'package:four_words_game/core/theme/app_themes.dart';
import 'package:four_words_game/features/history/presentation/state/history_notifier.dart';
import 'package:four_words_game/features/history/presentation/state/history_state.dart';

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
      appBar: AppBar(
        title: Text("History"),
        actions: [IconButton(onPressed: _clearHistory, icon: Icon(Icons.delete))],
      ),
      body: state.history.isNotEmpty ? _ListView(state: state) : _EmptyView(),
    );
  }

  Future<void> _clearHistory() async {
    final result1 = await _dialogBuilder1();
    if (result1 != true) {
      return;
    }

    final result2 = await _dialogBuilder2();
    if (result2 != true) {
      return;
    }

    await ref.read(historyProvider.notifier).clearHistory();
  }

  // First dialog to warn
  Future<bool?> _dialogBuilder1() {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("⚠️ Delete Progress?"),
          content: Text(
            "Are you sure you want to delete your game progress? This action cannot be undone and all your current achievements will be lost",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text("Cancel", style: context.textTheme.bodyLarge),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("Delete", style: context.textTheme.bodyLarge),
            ),
          ],
        );
      },
    );
  }

  // Second dialog to confirm
  Future<bool?> _dialogBuilder2() async {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("⚠️ Confirm Deletion"),
          content: Text(
            "This is your last chance. All your game progress will be permanently deleted and cannot be restored. Do you still want to continue?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text("Cancel", style: context.textTheme.bodyLarge),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("Delete", style: context.textTheme.bodyLarge),
            ),
          ],
        );
      },
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 64),
        SvgPicture.asset("assets/svg/no_data.svg", height: MediaQuery.of(context).size.height * 0.3),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Your history is empty", style: context.textTheme.titleLarge)],
        ),
      ],
    );
  }
}

class _ListView extends StatelessWidget {
  const _ListView({required this.state});

  final HistoryState state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }
}
