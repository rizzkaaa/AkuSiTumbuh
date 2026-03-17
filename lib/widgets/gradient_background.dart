import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget content;
  const GradientBackground({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFCCDDFB),
                  Color(0xFFE4E9FD),
                  Color(0xFFFBDDED),
                  Colors.white,
                ],
                stops: [0.0, 0.3, 0.6, 1.0],
              ),
            ),
          ),
          content
        ],
      );
  }
}