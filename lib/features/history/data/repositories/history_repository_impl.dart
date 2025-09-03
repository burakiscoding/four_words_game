import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_words_game/core/error/failures.dart';
import 'package:four_words_game/core/models/either.dart';
import 'package:four_words_game/features/history/data/datasources/history_local_data_source.dart';
import 'package:four_words_game/features/history/data/models/history_model.dart';
import 'package:four_words_game/features/history/data/models/history_word_model.dart';
import 'package:four_words_game/features/history/domain/entities/history_word_entity.dart';
import 'package:four_words_game/features/history/domain/repositories/history_repository.dart';

class HistoryRepositoryImpl extends HistoryRepository {
  final HistoryLocalDataSource _localDataSource;

  HistoryRepositoryImpl({required HistoryLocalDataSource localDataSource}) : _localDataSource = localDataSource;

  @override
  Future<Either<Failure, List<HistoryWordEntity>>> getHistory() async {
    try {
      final result = await _localDataSource.getHistory();
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return const Left(DbFailure());
    }
  }

  @override
  Future<void> insertHistory(int wordId, List<String> attempts) async {
    try {
      final history = HistoryModel(wordId: wordId, attempts: jsonEncode(attempts));
      return await _localDataSource.insertHistory(history);
    } catch (_) {}
  }

  @override
  Future<Either<Failure, int>> clearHistory() async {
    try {
      final result = await _localDataSource.clearHistory();
      return Right(result);
    } catch (_) {
      return const Left(DbFailure());
    }
  }
}

final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepositoryImpl(localDataSource: ref.watch(historyLocalDataSourceProvider));
});
