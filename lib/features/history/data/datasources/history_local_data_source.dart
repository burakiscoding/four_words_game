import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_words_game/core/db/db_client.dart';
import 'package:four_words_game/features/history/data/models/history_model.dart';
import 'package:four_words_game/features/history/data/models/history_word_model.dart';

abstract class HistoryLocalDataSource {
  Future<List<HistoryWordModel>> getHistory();
  Future<void> insertHistory(HistoryModel history);
}

class HistoryLocalDataSourceImpl extends HistoryLocalDataSource {
  final DbClient _dbClient;

  HistoryLocalDataSourceImpl({required DbClient dbClient}) : _dbClient = dbClient;

  @override
  Future<List<HistoryWordModel>> getHistory() async {
    final db = await _dbClient.db;

    final result = await db.rawQuery('''
    SELECT h.id, h.wordId, h.attempts, w.word, w.keywords 
    FROM history h 
    INNER JOIN word_cards w ON h.wordId = w.id
    ''');

    return result.map((e) => HistoryWordModel.fromMap(e)).toList();
  }

  @override
  Future<void> insertHistory(HistoryModel history) async {
    final db = await _dbClient.db;

    await db.insert('history', history.toMap());
  }
}

final historyLocalDataSourceProvider = Provider<HistoryLocalDataSource>((ref) {
  return HistoryLocalDataSourceImpl(dbClient: ref.watch(dbClientProvider));
});
