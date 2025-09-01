import 'package:flutter/material.dart';
import 'package:four_words_game/core/extensions/context_x.dart';

class KeywordsView extends StatelessWidget {
  final List<String> keywords;

  const KeywordsView({super.key, required this.keywords});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      alignment: WrapAlignment.center,
      children: keywords.map((word) => _KeywordCardView(word)).toList(),
    );
  }
}

class _KeywordCardView extends StatelessWidget {
  final String keyword;

  const _KeywordCardView(this.keyword);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.onPrimary),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      padding: const EdgeInsets.all(16),
      child: Text(keyword, style: context.textTheme.titleMedium, textAlign: TextAlign.center),
    );
  }
}
