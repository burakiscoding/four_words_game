import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_words_game/core/db/db_client.dart';
import 'package:four_words_game/features/game/data/models/word_card_model.dart';
import 'package:sqflite/sqflite.dart';

class DbSeedService {
  final DbClient _dbClient;

  DbSeedService({required DbClient dbClient}) : _dbClient = dbClient;

  Future<List<WordCardJson>> _loadWordCardsJson() async {
    final jsonString = await rootBundle.loadString('assets/data/word_cards.json');
    final jsonData = jsonDecode(jsonString) as List<dynamic>;
    return jsonData.map((e) => WordCardJson.fromMap(e)).toList();
  }

  Future<void> insertWordCards() async {
    final db = await _dbClient.db;

    final wordCards = await _loadWordCardsJson();
    final result = await db.query('word_cards');

    // Database is already seeded and Json file isn't changed
    if (result.length == wordCards.length) {
      return;
    }

    // First time inserting words or the user cleared db
    if (result.isEmpty) {
      for (final w in wordCards) {
        await db.insert('word_cards', w.toModel().toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      }
      return;
    }

    // We already have words in db but we want to add more
    final lastWordId = result.last['id'] as int;
    for (final w in wordCards) {
      // Only new words will be inserted
      if (w.id > lastWordId) {
        await db.insert('word_cards', w.toModel().toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }
}

class WordCardJson {
  final int id;
  final String word;
  final List<String> keywords;

  const WordCardJson({required this.id, required this.word, required this.keywords});

  factory WordCardJson.fromMap(Map<String, dynamic> map) {
    return WordCardJson(
      id: map['id'] as int,
      word: map['word'] as String,
      keywords: List<String>.from(map['keywords'] as List<dynamic>),
    );
  }
}

extension WordCardJsonX on WordCardJson {
  WordCardModel toModel() {
    return WordCardModel(id: id, word: word, keywords: jsonEncode(keywords), isCompleted: 0);
  }
}

final dbSeedServiceProvider = Provider<DbSeedService>((ref) {
  return DbSeedService(dbClient: ref.watch(dbClientProvider));
});
