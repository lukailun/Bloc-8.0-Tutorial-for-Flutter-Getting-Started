import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/colors.dart';
import '../bloc/game_bloc.dart';
import 'aligned_grid.dart';
import 'guess_cell.dart';

/// Displays the game board.
class Board extends StatelessWidget {
  /// Constructor
  const Board({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final guesses = context.watch<GameBloc>().state.guesses;
    final puzzle = context.watch<GameBloc>().state.puzzle;

    return AlignedGrid(
      padding: const EdgeInsets.symmetric(vertical: 16),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      maxAxisCount: 5,
      childAspectRatio: 1 / 1,
      children: guesses
          .map((row) => row
              .map((letter) => GuessCell(
                    color: defineGuessCellColor(
                      row,
                      puzzle,
                      letter,
                    ),
                    content: letter,
                  ))
              .toList())
          .expand((row) => row)
          .toList(),
    );
  }

  /// Helper function that defines the color of a guess cell.
  Color? defineGuessCellColor(
    List<String> row,
    String puzzle,
    String letter,
  ) {
    final letterCount =
        row.reduce((letter, anotherLetter) => letter + anotherLetter);

    if (letter.isEmpty || letterCount.length < 5 || !puzzle.contains(letter)) {
      return null;
    }

    final position = row.indexOf(letter);
    if (position != -1 && puzzle[position] == letter) {
      return AppColors.success;
    }

    return AppColors.warning;
  }
}
