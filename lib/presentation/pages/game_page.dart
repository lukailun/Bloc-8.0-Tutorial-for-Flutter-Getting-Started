import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/game_bloc.dart';
import '../widgets/board.dart';
import '../widgets/plingo_appbar.dart';
import '../widgets/plingo_keyboard.dart';

/// HomePage widget.
///
/// [Scaffold] that displays the KeyMotion menu
class GamePage extends StatelessWidget {
  /// @macro home_page
  const GamePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PlingoAppBar(),
      body: SafeArea(
        child: _Game(),
      ),
    );
  }
}

class _Game extends StatelessWidget {
  const _Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GameBloc>().state;

    if (state.status == GameStatus.initial ||
        state.status == GameStatus.inProgress) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          const Expanded(child: Board()),
          const PlingoKeyboard(),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            state.status == GameStatus.success
                ? 'You\'ve won!\nYour lingo is growing strong.'
                : 'You\'ve lost!\nOur playful lingo was too strong. ',
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
        ),
        const Board(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: ElevatedButton(
            onPressed: () => context.read<GameBloc>().add(const GameStarted()),
            child: const Text('Play again!'),
          ),
        ),
      ],
    );
  }
}
