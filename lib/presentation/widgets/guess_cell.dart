import 'package:flutter/material.dart';

import '../../app/colors.dart';

/// Displays the guess in a cell.
class GuessCell extends StatelessWidget {
  /// Constructor
  const GuessCell({
    Key? key,
    required this.content,
    Color? color,
  })  : color = color ?? AppColors.shade2,
        super(key: key);

  /// Content to be displayed.
  final String content;

  /// Background color for the guess cell.
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          content.toUpperCase(),
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
        ),
      ),
    );
  }
}
