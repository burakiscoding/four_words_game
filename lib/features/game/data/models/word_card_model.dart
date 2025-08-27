class WordCardModel {
  final int id;
  final String word;
  final List<String> keywords;
  final bool isCompleted;

  WordCardModel({required this.id, required this.word, required this.keywords, required this.isCompleted});
}
