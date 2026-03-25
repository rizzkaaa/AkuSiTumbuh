import 'package:flutter/material.dart';

class BgCreate extends StatelessWidget {
  final Widget child;
  final List<Color>? colors;
  final List<double>? stops;
  final BorderRadius? borderRadius;

  const BgCreate({
    super.key,
    required this.child,
    this.colors,
    this.stops,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: 570
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              colors ??
              [
                const Color(0xFFB7C8E8).withValues(alpha: 0.5),
                const Color(0xFFF5B6D7).withValues(alpha: 0.5),
              ],
          stops: stops ?? const [0.0, 0.85],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius:
            borderRadius ??
            const BorderRadius.only(
              topRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
        border: const Border.symmetric(
          vertical: BorderSide(color: Color(0xFFD6A7C9), width: 5),
        ),
      ),
      child: child,
    );
  }
}
