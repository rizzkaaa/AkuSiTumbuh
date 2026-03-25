import 'package:flutter/material.dart';

class GradientBackgtound3 extends StatelessWidget {
  final Widget child;
  const GradientBackgtound3({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
              stops: [0.0, 0.3, 0.5, 1.0],
            ),
          ),
        ),

        child,
      ],
    );
  }
}
