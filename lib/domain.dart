import 'package:equatable/equatable.dart';

/// All the keys available for typing grouped by rows to be
/// shown in the keyboard.
const keyboardKeys = [
  'qwertyuiop',
  'asdfghjkl',
  'zxcvbnm',
];

/// Amount of guesses allowed by the game.
const kMaxGuesses = 5;

/// Length of the word being guessed.
const kWordLength = 5;

/// Default empty list of guesses.
List<List<String>> emptyGuesses() {
  return List<List<String>>.generate(
    kMaxGuesses,
    (_) => List.from(List<String>.generate(kWordLength, (_) => '')),
  );
}

/// Helper function that finds and fills the next empty space available with
/// the letter provided and returns the updated list.
///
/// If the letter is empty, then the same [guesses] is returned.
List<List<String>> addLetterToGuesses(
  List<List<String>> guesses,
  String letter,
) {
  if (letter.isEmpty) return guesses;

  final newGuesses = guesses.map((guess) => guess.toList()).toList();

  var stop = false;

  for (var i = 0; i < newGuesses.length; i++) {
    for (var j = 0; j < newGuesses[i].length; j++) {
      if (newGuesses[i][j].isEmpty) {
        newGuesses[i][j] = letter;
        stop = true;
        break;
      }
    }

    if (stop) break;
  }

  return newGuesses;
}

/// Chooses the next random word puzzle from a list of puzzles.
String nextPuzzle(List<String> puzzles) => (puzzles.toList()..shuffle()).first;

/// Defines the statistics that the game gathers for the player.
class GameStats extends Equatable {
  /// Constructor
  const GameStats({
    this.gamesPlayed = -1,
    this.gamesWon = -1,
    this.longestStreak = -1,
    this.currentStreak = -1,
  });

  /// Amount of games played.
  final int gamesPlayed;

  /// Amount of games won.
  final int gamesWon;

  /// Longest streak of games won.
  final int longestStreak;

  /// Current streak of games won.
  final int currentStreak;

  /// Percentage of games won
  double get winRate {
    return gamesPlayed >= 0
        ? (gamesWon / (gamesPlayed == 0 ? 1 : gamesPlayed)) * 100
        : -1;
  }

  /// Provides empty instance of statistics.
  static const empty = GameStats();

  @override
  List<Object?> get props => [
        gamesPlayed,
        gamesWon,
        longestStreak,
        currentStreak,
      ];

  /// Provides a copied instance.
  GameStats copyWith({
    int? gamesPlayed,
    int? gamesWon,
    int? longestStreak,
    int? currentStreak,
  }) =>
      GameStats(
        gamesPlayed: gamesPlayed ?? this.gamesPlayed,
        gamesWon: gamesWon ?? this.gamesWon,
        longestStreak: longestStreak ?? this.longestStreak,
        currentStreak: currentStreak ?? this.currentStreak,
      );
}

/// List of all the possible word puzzles in the game.
final puzzles = [
  // Nouns
  'lingo',
  // Verbs
  'admit',
  'adopt',
  'agree',
  'allow',
  'alter',
  'apply',
  'argue',
  'arise',
  'avoid',
  'begin',
  'blame',
  'break',
  'bring',
  'build',
  'burst',
  'carry',
  'catch',
  'cause',
  'check',
  'claim',
  'clean',
  'clear',
  'climb',
  'close',
  'count',
  'cover',
  'cross',
  'dance',
  'doubt',
  'drink',
  'drive',
  'enjoy',
  'enter',
  'exist',
  'fight',
  'focus',
  'force',
  'guess',
  'imply',
  'issue',
  'judge',
  'laugh',
  'learn',
  'leave',
  'limit',
  'marry',
  'match',
  'occur',
  'offer',
  'order',
  'phone',
  'place',
  'point',
  'press',
  'prove',
  'raise',
  'reach',
  'refer',
  'relax',
  'serve',
  'shall',
  'share',
  'shift',
  'shoot',
  'sleep',
  'solve',
  'sound',
  'speak',
  'spend',
  'split',
  'stand',
  'start',
  'state',
  'stick',
  'study',
  'teach',
  'thank',
  'think',
  'throw',
  'touch',
  'train',
  'treat',
  'trust',
  'visit',
  'voice',
  'waste',
  'watch',
  'worry',
  'would',
  'write',
// Adjectives
  'above',
  'acute',
  'alive',
  'alone',
  'angry',
  'aware',
  'awful',
  'basic',
  'black',
  'blind',
  'brave',
  'brief',
  'broad',
  'brown',
  'cheap',
  'chief',
  'civil',
  'clean',
  'clear',
  'close',
  'crazy',
  'daily',
  'dirty',
  'early',
  'empty',
  'equal',
  'exact',
  'extra',
  'faint',
  'false',
  'fifth',
  'final',
  'first',
  'fresh',
  'front',
  'funny',
  'giant',
  'grand',
  'great',
  'green',
  'gross',
  'happy',
  'harsh',
  'heavy',
  'human',
  'ideal',
  'inner',
  'joint',
  'large',
  'legal',
  'level',
  'light',
  'local',
  'loose',
  'lucky',
  'magic',
  'major',
  'minor',
  'moral',
  'naked',
  'nasty',
  'naval',
  'other',
  'outer',
  'plain',
  'prime',
  'prior',
  'proud',
  'quick',
  'quiet',
  'rapid',
  'ready',
  'right',
  'roman',
  'rough',
  'round',
  'royal',
  'rural',
  'sharp',
  'sheer',
  'short',
  'silly',
  'sixth',
  'small',
  'smart',
  'solid',
  'sorry',
  'spare',
  'steep',
  'still',
  'super',
  'sweet',
  'thick',
  'third',
  'tight',
  'total',
  'tough',
  'upper',
  'upset',
  'urban',
  'usual',
  'vague',
  'valid',
  'vital',
  'white',
  'whole',
  'wrong',
  'young',
];
