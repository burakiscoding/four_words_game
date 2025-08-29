import 'dart:convert';

import 'package:four_words_game/features/history/domain/entities/history_word_entity.dart';

class HistoryWordModel {
  final int id;
  final int wordId;
  final String attempts;
  final String word;
  final String keywords;

  const HistoryWordModel({
    required this.id,
    required this.wordId,
    required this.attempts,
    required this.word,
    required this.keywords,
  });

  factory HistoryWordModel.fromMap(Map<String, dynamic> map) {
    return HistoryWordModel(
      id: map['id'] as int,
      wordId: map['wordId'] as int,
      attempts: map['attempts'] as String,
      word: map['word'] as String,
      keywords: map['keywords'] as String,
    );
  }
}

extension HistoryWordModelX on HistoryWordModel {
  HistoryWordEntity toEntity() {
    return HistoryWordEntity(
      id: id,
      wordId: wordId,
      attempts: List<String>.from(jsonDecode(attempts) as List<dynamic>),
      word: word,
      keywords: List<String>.from(jsonDecode(keywords) as List<dynamic>),
    );
  }
}
