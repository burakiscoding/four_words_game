import 'package:flutter/material.dart';

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
      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(4))),
      padding: const EdgeInsets.all(16),
      child: Text(keyword, textAlign: TextAlign.center),
    );
  }
}
