part of 'game_bloc.dart';

/// Base event for all game related actions.
abstract class GameEvent extends Equatable {
  /// Constructor
  const GameEvent();

  @override
  List<Object> get props => [];
}

/// Performed when a key on PlingoKeyboard is used.
class LetterKeyPressed extends GameEvent {
  /// Constructor
  const LetterKeyPressed(this.letter);

  /// Letter that was pressed.
  final String letter;

  @override
  List<Object> get props => [letter];
}

/// Performed when a new game starts.
class GameStarted extends GameEvent {
  /// Constructor
  const GameStarted() : super();
}

/// Performed when the game finishes after winning or losing.
class GameFinished extends GameEvent {
  /// Constructor
  const GameFinished({this.hasWon = false}) : super();

  /// Flag indicating the result of the game.
  final bool hasWon;
}
