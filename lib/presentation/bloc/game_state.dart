part of 'game_bloc.dart';

/// Possible game states.
enum GameStatus {
  /// When the game has no guesses
  initial,

  /// When the game has at least one guess
  inProgress,

  /// When the player successfully guesses the puzzle.
  success,

  /// When the player fails to guess the puzzle
  /// and has no more attempts available.
  failure,
}

/// Game state.
class GameState extends Equatable {
  /// Constructor
  const GameState({
    this.status = GameStatus.initial,
    this.guesses = const [],
    this.puzzle = '',
  });

  /// Current status of the game,
  final GameStatus status;

  /// The puzzle for the current game.
  final String puzzle;

  /// A list of the guesses available for the game.
  final List<List<String>> guesses;

  @override
  List<Object> get props => [
        status,
        puzzle,
        guesses,
      ];

  /// Provides a copied instance.
  GameState copyWith({
    GameStatus? status,
    String? puzzle,
    List<List<String>>? guesses,
  }) =>
      GameState(
        status: status ?? this.status,
        puzzle: puzzle ?? this.puzzle,
        guesses: guesses ?? this.guesses,
      );
}
