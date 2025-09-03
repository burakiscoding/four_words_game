class WordCardEntity {
  final int id;
  final String word;
  final List<String> keywords;
  final bool isCompleted;

  const WordCardEntity({required this.id, required this.word, required this.keywords, required this.isCompleted});

  const WordCardEntity.initial({this.id = 0, this.word = '', this.keywords = const [], this.isCompleted = false});

  const WordCardEntity.example({
    this.id = 1,
    this.word = 'SCHOOL',
    this.keywords = const ["Teacher", "Student", "Homework Long Version"],
    this.isCompleted = false,
  });

  WordCardEntity copyWith({int? id, String? word, List<String>? keywords, bool? isCompleted}) {
    return WordCardEntity(
      id: id ?? this.id,
      word: word ?? this.word,
      keywords: keywords ?? this.keywords,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
