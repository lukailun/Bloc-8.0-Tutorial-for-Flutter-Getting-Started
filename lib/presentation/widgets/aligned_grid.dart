import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// A Grid that wraps the different children and allows for alignment of the
/// rows available.
class AlignedGrid extends StatelessWidget {
  /// Padding for the grid.
  final EdgeInsetsGeometry padding;

  /// Spacing for the cross axis.
  final double crossAxisSpacing;

  /// Spacing for the main axis.
  final double mainAxisSpacing;

  /// Amount of items peer main axis.
  final int maxAxisCount;

  /// Alignment of the rows if there's space available.
  final WrapAlignment alignment;

  /// Child aspect ratio, if null then children will take all availabl space.
  final double? childAspectRatio;

  /// Scroll physics.
  final ScrollPhysics? physics;

  /// The list of widgets to be displayed in the grid.
  final List<Widget> children;

  /// Constructor.
  const AlignedGrid({
    Key? key,
    required this.children,
    this.padding = EdgeInsets.zero,
    this.alignment = WrapAlignment.center,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
    this.maxAxisCount = 1,
    this.childAspectRatio,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final verticalPadding = padding.vertical;
    final spacingSumWidth = mainAxisSpacing * (maxAxisCount - 1);
    final availableWidth =
        MediaQuery.of(context).size.width - verticalPadding - spacingSumWidth;

    final itemWidth = availableWidth / maxAxisCount;
    return SingleChildScrollView(
      physics: physics,
      child: Padding(
        padding: EdgeInsets.zero,
        child: Wrap(
          runSpacing: crossAxisSpacing,
          spacing: mainAxisSpacing,
          alignment: alignment,
          children: children
              .map(
                (child) => ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: itemWidth),
                  child: childAspectRatio != null
                      ? AspectRatio(
                          aspectRatio: childAspectRatio!,
                          child: child,
                        )
                      : child,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
