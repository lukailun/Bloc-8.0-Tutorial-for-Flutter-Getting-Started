import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/colors.dart';
import '../cubit/stats_cubit.dart';
import '../widgets/stat_cell.dart';

/// Dialog of the game's statistics.
class GameStatsDialog extends StatelessWidget {
  /// Constructor
  const GameStatsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stats = context.watch<StatsCubit>().state.stats;

    return SimpleDialog(
      backgroundColor: AppColors.shade1,
      contentPadding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 32.0),
      titlePadding: const EdgeInsets.all(24.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Statistics',
            textAlign: TextAlign.center,
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () => Navigator.pop(context),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.close,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatCell(
              stat: stats.gamesPlayed.toString(),
              description: 'Played',
            ),
            StatCell(
              stat: stats.winRate.toStringAsFixed(0),
              description: 'Win %',
            ),
            StatCell(
              stat: stats.currentStreak.toString(),
              description: 'Current\nStreak',
            ),
            StatCell(
              stat: stats.longestStreak.toString(),
              description: 'Longest\nStreak',
            ),
          ],
        ),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: OutlinedButton(
            onPressed: () => context.read<StatsCubit>().resetStats(),
            child: const Text('Reset'),
          ),
        ),
      ],
    );
  }
}
