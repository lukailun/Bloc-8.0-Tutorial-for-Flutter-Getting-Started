import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/colors.dart';
import '../../domain.dart';
import '../bloc/game_bloc.dart';
import 'aligned_grid.dart';
import 'plingo_key.dart';

/// Displays the keyboard available for creating word guesses.
class PlingoKeyboard extends StatelessWidget {
  /// Constructor
  const PlingoKeyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final guesses = context.watch<GameBloc>().state.guesses;
    final puzzle = context.watch<GameBloc>().state.puzzle;

    final attemptedLetters = guesses
        .where((guess) => guess.join().length == kWordLength)
        .expand((guess) => guess)
        .where((letter) => letter.isNotEmpty)
        .toList();

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 32),
      child: AlignedGrid(
        crossAxisSpacing: 16,
        children: keyboardKeys
            .map(
              (row) => AlignedGrid(
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 6,
                crossAxisSpacing: 4,
                maxAxisCount: 10,
                padding: const EdgeInsets.all(16),
                childAspectRatio: 1 / 1.5,
                children: row.characters
                    .map(
                      (letter) => PlingoKey(
                        letter: letter,
                        color: definePlingoKeyColor(
                          attemptedLetters,
                          puzzle,
                          letter,
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
            .toList(),
      ),
    );
  }

  /// Helper function that defines the color of a guess cell.
  Color? definePlingoKeyColor(
    List<String> attemptedLetters,
    String puzzle,
    String letter,
  ) {
    if (letter.isEmpty || !attemptedLetters.contains(letter)) {
      return null;
    }

    final position = puzzle.indexOf(letter);
    if (attemptedLetters.contains(letter)) {
      if (position != -1) {
        return AppColors.success;
      }

      return AppColors.shade2;
    }

    return null;
  }
}
