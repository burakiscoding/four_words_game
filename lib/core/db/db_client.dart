import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbClient {
  late final Future<Database> db = _openConnection();

  Future<Database> _openConnection() async {
    return openDatabase(
      join(await getDatabasesPath(), 'game_database.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE word_cards(id INTEGER PRIMARY KEY, word TEXT, keywords TEXT, isCompleted INTEGER)',
        );
        return db.execute(
          'CREATE TABLE history(id INTEGER PRIMARY KEY AUTOINCREMENT, attempts TEXT, wordId INTEGER, FOREIGN KEY (wordId) REFERENCES word_cards(id) ON DELETE SET NULL)',
        );
      },
      version: 1,
      onConfigure: (db) {
        return db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }
}

final dbClientProvider = Provider<DbClient>((ref) {
  return DbClient();
});
