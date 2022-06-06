part of 'stats_cubit.dart';

/// Holds information about the statistics of games played.
class StatsState extends Equatable {
  /// Constructor
  const StatsState({
    this.stats = GameStats.empty,
  });

  /// Statistics of the games played.
  final GameStats stats;

  @override
  List<Object> get props => [
        stats,
      ];

  /// Provides a copied instance.
  StatsState copyWith({
    GameStats? stats,
  }) =>
      StatsState(
        stats: stats ?? this.stats,
      );
}
