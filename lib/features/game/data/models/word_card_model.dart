import 'dart:convert';

import 'package:four_words_game/features/game/domain/entities/word_card_entity.dart';

class WordCardModel {
  final int id;
  final String word;
  final String keywords;
  final int isCompleted;

  WordCardModel({required this.id, required this.word, required this.keywords, required this.isCompleted});

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
      keywords: jsonDecode(keywords) as List<String>,
      isCompleted: isCompleted == 1,
    );
  }
}
