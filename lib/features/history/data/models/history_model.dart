class HistoryModel {
  final int? id;
  final int wordId;
  final String attempts;

  const HistoryModel({this.id, required this.wordId, required this.attempts});

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(id: map['id'] as int, wordId: map['wordId'] as int, attempts: map['attempts'] as String);
  }

  Map<String, Object?> toMap() {
    return {'id': id, 'wordId': wordId, 'attempts': attempts};
  }

  @override
  String toString() {
    return 'HistoryModel{id: $id, wordId: $wordId, attempts: $attempts}';
  }
}
