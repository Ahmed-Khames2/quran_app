import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SallahAlaMohamed extends StatelessWidget {
  const SallahAlaMohamed({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'اللهم صلِّ وسلم على نبينا محمد',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'me_quran', // Custom font if available
              color: theme.textTheme.titleLarge?.color ?? theme.appBarTheme.backgroundColor, // Text color adapts to theme
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // You can add more elements or functionality as needed
        ],
      ),
    );
  }
}
