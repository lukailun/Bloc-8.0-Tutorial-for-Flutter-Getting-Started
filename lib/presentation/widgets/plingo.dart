import 'package:flutter/material.dart';

/// Displays the logo for Plingo
class Plingo extends StatelessWidget {
  /// Constructor
  const Plingo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      fit: BoxFit.contain,
    );
  }
}
