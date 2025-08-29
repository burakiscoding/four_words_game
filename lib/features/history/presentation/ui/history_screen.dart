import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      backgroundColor: Color.fromRGBO(253, 251, 234, 1),
      appBar: AppBar(title: Text("History"), backgroundColor: Color.fromRGBO(253, 251, 234, 1)),
      body: ListView.builder(
        itemCount: state.history.length,
        itemBuilder: (context, index) {
          final item = state.history[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Word: "),
                    Text(item.word, style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Keywords: "),
                    Text(item.keywords.join(','), style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),

                _AttemptsView(item.attempts),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AttemptsView extends StatelessWidget {
  final List<String> attempts;

  const _AttemptsView(this.attempts);

  @override
  Widget build(BuildContext context) {
    if (attempts.isEmpty) {
      return Text("You won on your first try.", style: Theme.of(context).textTheme.titleMedium);
    }

    return Column(
      children: [
        Text("Attempts before winning:"),
        Wrap(children: attempts.map((e) => Text("$e, ")).toList()),
      ],
    );
  }
}
