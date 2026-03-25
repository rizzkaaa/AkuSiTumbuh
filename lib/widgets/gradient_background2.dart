import 'dart:ui';
import 'package:flutter/material.dart';

class GradientBackground2 extends StatelessWidget {
  final Widget content;
  final List<double> offset1;
  final List<double> offset2;

  const GradientBackground2({
    super.key,
    required this.content,
    required this.offset1,
    required this.offset2,
  });

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

        _buildBlurLayer(offset1, 250, Color(0xFF92A6CD)),
        _buildBlurLayer(offset2, 270, Color(0xFFD6A7C9)),
        content,
      ],
    );
  }

  Widget _buildBlurLayer(List<double> offset, double size, Color color) {
    return AnimatedPositioned(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      left: offset[0],
      top: offset[1],
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.8),
                  blurRadius: 50,
                  spreadRadius: 10,
                ),
                BoxShadow(
                  color: color.withValues(alpha: 0.5),
                  blurRadius: 20,
                  spreadRadius: 30,
                ),
              ],
              shape: BoxShape.circle,

              color: color,
            ),
          ),

          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ],
      ),
    );
  }
}
