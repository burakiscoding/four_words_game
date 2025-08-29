class HistoryWordEntity {
  final int id;
  final int wordId;
  final List<String> attempts;
  final String word;
  final List<String> keywords;

  const HistoryWordEntity({
    required this.id,
    required this.wordId,
    required this.attempts,
    required this.word,
    required this.keywords,
  });
}
