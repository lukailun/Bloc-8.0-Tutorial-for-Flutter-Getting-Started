import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data.dart';
import '../cubit/stats_cubit.dart';
import '../dialogs/stats_dialog.dart';
import 'plingo.dart';

/// Default implementation of the app bar used in Pling
class PlingoAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Constructor
  const PlingoAppBar({Key? key}) : super(key: key);

  static const _kSpacing = 16;
  static const _kToolbarHeight = 64.0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: _kToolbarHeight,
      title: SizedBox.fromSize(
        size: const Size.fromHeight(kToolbarHeight - _kSpacing),
        child: const Plingo(),
      ),
      leading: const SizedBox(
        width: 32,
      ),
      actions: [
        IconButton(
          onPressed: () => showDialog<void>(
            context: context,
            builder: (dContext) => BlocProvider(
              create: (bContext) => StatsCubit(
                context.read<GameStatsRepository>(),
              )..fetchStats(),
              child: const GameStatsDialog(),
            ),
          ),
          icon: const Icon(Icons.leaderboard_rounded),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_kToolbarHeight);
}
