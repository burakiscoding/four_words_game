import 'package:four_words_game/features/game/domain/entities/word_card_entity.dart';
import 'package:four_words_game/features/game/presentation/models/letter.dart';

class GameState {
  /// Input word typed by the user
  final WordString word;

  /// Current word card being played
  final WordCardEntity wordCard;

  /// Last word typed by the user
  final Word lastWord;

  final int index;

  /// Indicates whether the game is loading
  final bool isLoading;

  /// Error message to display
  final String? errorMessage;

  /// Indicates whether the user has won the game
  final bool isWin;

  /// Seconds before the next word
  final int remainingSeconds;

  /// Returns true if all words in db are completed
  final bool isWordsOver;

  const GameState({
    required this.word,
    required this.wordCard,
    required this.lastWord,
    this.index = 0,
    this.isLoading = false,
    this.errorMessage,
    this.isWin = false,
    this.remainingSeconds = 3,
    this.isWordsOver = false,
  });

  const GameState.initial({
    this.word = const [],
    this.wordCard = const WordCardEntity.initial(),
    this.lastWord = const [],
    this.index = 0,
    this.isLoading = false,
    this.errorMessage,
    this.isWin = false,
    this.remainingSeconds = 3,
    this.isWordsOver = false,
  });

  GameState copyWith({
    WordString? word,
    WordCardEntity? wordCard,
    Word? lastWord,
    int? index,
    bool? isLoading,
    String? errorMessage,
    bool? isWin,
    int? remainingSeconds,
    bool? isWordsOver,
  }) {
    return GameState(
      word: word ?? this.word,
      wordCard: wordCard ?? this.wordCard,
      lastWord: lastWord ?? this.lastWord,
      index: index ?? this.index,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isWin: isWin ?? this.isWin,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isWordsOver: isWordsOver ?? this.isWordsOver,
    );
  }
}
