import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbClient {
  late final Future<Database> db = _openConnection();

  Future<Database> _openConnection() async {
    return openDatabase(
      join(await getDatabasesPath(), 'game_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE word_cards(id INTEGER PRIMARY KEY, word TEXT, keywords TEXT, isCompleted INTEGER)',
        );
      },
      version: 1,
    );
  }
}

final dbClientProvider = Provider<DbClient>((ref) {
  return DbClient();
});
