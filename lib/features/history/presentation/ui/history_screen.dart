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
      backgroundColor: Color(0xFFFFF2EB),
      appBar: AppBar(
        title: Text(
          "History",
          style: TextStyle(fontFamily: 'PermanentMarker', fontWeight: FontWeight.w700),
        ),
        backgroundColor: Color(0xFFFFF2EB),
      ),
      body: ListView.builder(
        itemCount: state.history.length,
        itemBuilder: (context, index) {
          final item = state.history[index];

          return ListTile(
            leading: CircleAvatar(backgroundColor: Color(0xffFFD6BA), child: Text(item.id.toString())),
            title: Text(item.word),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.keywords.join(',')),
                RichText(
                  text: TextSpan(
                    children: [
                      ...item.attempts.map(
                        (e) => TextSpan(
                          text: "$e, ",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextSpan(
                        text: item.word,
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
