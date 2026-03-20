import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  final Color color;

  const TypingIndicator({
    super.key,
    required this.color,
  });

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _bounce(double value, double delay) {
    final t = (value - delay) % 1.0;
    if (t < 0) return 0;
    return (0.5 - (t - 0.5).abs()) * 2; 
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            final delay = i * 0.5;
            final scale = 1 + (_bounce(_controller.value, delay) * 0.4);

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 1),
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}