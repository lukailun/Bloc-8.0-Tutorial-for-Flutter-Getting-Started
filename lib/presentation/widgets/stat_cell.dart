import 'package:flutter/material.dart';

/// Displays a statistic's information in a cell.
class StatCell extends StatelessWidget {
  /// Constructor
  const StatCell({
    Key? key,
    required this.stat,
    this.description,
  }) : super(key: key);

  /// Displays the stat. It is usually a number.
  final String stat;

  /// Describes the stat.
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          stat,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
        ),
        if (description != null) ...[
          const SizedBox(height: 8),
          Text(
            description!,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
