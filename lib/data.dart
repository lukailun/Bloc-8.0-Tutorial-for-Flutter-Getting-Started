import 'package:shared_preferences/shared_preferences.dart';

import 'domain.dart';

/// Interacts with shared preferences to store and retrieve data
/// about statistics of the game.
class GameStatsSharedPrefProvider {
  /// Key for retrieving data that indicates the amount of games played.
  static const kGamesPlayed = 'GAMES_PLAYED';

  /// Key for retrieving data that indicates the amount of games won.
  static const kGamesWon = 'GAMES_WON';

  /// Key for retrieving data that indicates the longest streak of games won.
  static const kLongestStreak = 'GAMES_LONGEST_STREAK';

  /// Key for retrieving data that indicates the current streak of games won.
  static const kCurrentStreak = 'GAMES_CURRENT_STREAK';

  /// Updates the value of a given stat.
  Future<bool> updateStat(String key, int value) async {
    final _prefs = await SharedPreferences.getInstance();

    return _prefs.setInt(key, value);
  }

  /// Updates the value of a given stat.
  Future<int> fetchStat(String key) async {
    final _prefs = await SharedPreferences.getInstance();

    return _prefs.getInt(key) ?? 0;
  }
}

/// Provides information about statistics of the games played.
class GameStatsRepository {
  /// Constructor
  GameStatsRepository(this.provider);

  /// Interacts with shared preferences to store and retrieve data.
  final GameStatsSharedPrefProvider provider;

  /// Fetches the game stats.
  Future<GameStats> fetchStats() async {
    return GameStats(
      gamesPlayed:
          await provider.fetchStat(GameStatsSharedPrefProvider.kGamesPlayed),
      gamesWon: await provider.fetchStat(GameStatsSharedPrefProvider.kGamesWon),
      longestStreak:
          await provider.fetchStat(GameStatsSharedPrefProvider.kLongestStreak),
      currentStreak:
          await provider.fetchStat(GameStatsSharedPrefProvider.kCurrentStreak),
    );
  }

  /// Adds a new game to the count of games played, and if won it also adds it
  /// to the games won stat. It also updates the current streak and longest
  /// streak as needed.
  Future<void> addGameFinished({
    bool hasWon = false,
  }) async {
    final current = await fetchStats();

    await provider.updateStat(
      GameStatsSharedPrefProvider.kGamesPlayed,
      current.gamesPlayed + 1,
    );

    if (hasWon) {
      await provider.updateStat(
        GameStatsSharedPrefProvider.kGamesWon,
        current.gamesWon + 1,
      );

      await provider.updateStat(
        GameStatsSharedPrefProvider.kCurrentStreak,
        current.currentStreak + 1,
      );

      if (current.currentStreak == current.longestStreak) {
        await provider.updateStat(
          GameStatsSharedPrefProvider.kLongestStreak,
          current.longestStreak + 1,
        );
      }
    } else {
      await provider.updateStat(
        GameStatsSharedPrefProvider.kCurrentStreak,
        0,
      );
    }
  }

  /// Resets the stats stored locally.
  Future<void> resetStats() async {
    await provider.updateStat(
      GameStatsSharedPrefProvider.kGamesWon,
      0,
    );
    await provider.updateStat(
      GameStatsSharedPrefProvider.kGamesPlayed,
      0,
    );
    await provider.updateStat(
      GameStatsSharedPrefProvider.kCurrentStreak,
      0,
    );
    await provider.updateStat(
      GameStatsSharedPrefProvider.kLongestStreak,
      0,
    );
  }
}
