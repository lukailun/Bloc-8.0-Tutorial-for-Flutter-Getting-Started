import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../data.dart';
import '../../domain.dart';

part 'game_event.dart';

part 'game_state.dart';

/// Handles all logic related to the game.
class GameBloc extends Bloc<GameEvent, GameState> {
  /// Constructor
  GameBloc(this._statsRepository)
      : super(GameState(
          guesses: emptyGuesses(),
        )) {
    on<GameStarted>(_onGameStarted);
    on<LetterKeyPressed>(_onLetterKeyPressed, transformer: sequential());
    on<GameFinished>(_onGameFinished);
  }

  /// Interacts with storage for updating game stats.
  final GameStatsRepository _statsRepository;

  void _onGameStarted(
    GameStarted event,
    Emitter<GameState> emit,
  ) {
    print('Game has started!');
    final puzzle = nextPuzzle(puzzles);
    final guesses = emptyGuesses();
    emit(GameState(
      guesses: guesses,
      puzzle: puzzle,
    ));
  }

  Future<void> _onLetterKeyPressed(
    LetterKeyPressed event,
    Emitter<GameState> emit,
  ) async {
    final puzzle = state.puzzle;
    final guesses = addLetterToGuesses(state.guesses, event.letter);
    emit(state.copyWith(
      guesses: guesses,
    ));
    final words = guesses
        .map((guess) => guess.join())
        .where((word) => word.isNotEmpty)
        .toList();
    final hasWon = words.contains(puzzle);
    final hasMaxAttempts = words.length == kMaxGuesses &&
        words.every((word) => word.length == kWordLength);
    if (hasWon || hasMaxAttempts) {
      add(GameFinished(hasWon: hasWon));
    }
  }

  Future<void> _onGameFinished(
    GameFinished event,
    Emitter<GameState> emit,
  ) async {
    await _statsRepository.addGameFinished(hasWon: event.hasWon);
    emit(state.copyWith(
      status: event.hasWon ? GameStatus.success : GameStatus.failure,
    ));
  }
}
