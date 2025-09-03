import 'dart:convert';

import 'package:four_words_game/features/game/domain/entities/word_card_entity.dart';

class WordCardModel {
  final int id;
  final String word;
  final String keywords;
  final int isCompleted;

  const WordCardModel({required this.id, required this.word, required this.keywords, required this.isCompleted});

  factory WordCardModel.fromMap(Map<String, dynamic> map) {
    return WordCardModel(
      id: map['id'] as int,
      word: map['word'] as String,
      keywords: map['keywords'] as String,
      isCompleted: map['isCompleted'] as int,
    );
  }

  Map<String, Object?> toMap() {
    return {'id': id, 'word': word, 'keywords': keywords, 'isCompleted': isCompleted};
  }

  @override
  String toString() {
    return 'WordCardModel{id: $id, word: $word, keywords: $keywords, isCompleted: $isCompleted}';
  }
}

extension WordCardModelX on WordCardModel {
  WordCardEntity toEntity() {
    return WordCardEntity(
      id: id,
      word: word,
      keywords: List<String>.from(jsonDecode(keywords) as List<dynamic>),
      isCompleted: isCompleted == 1,
    );
  }
}
