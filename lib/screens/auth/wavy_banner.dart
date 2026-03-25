import 'package:flutter/material.dart';

class WavyBannerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();

    path.lineTo(0, 0);
    path.lineTo(w, 0);
    path.lineTo(w, h * 0.601);

    path.cubicTo(
      w * 0.864,
      h * 0.816,
      w * 0.638,
      h * 0.764,
      w * 0.565,
      h * 0.653,
    );

    path.cubicTo(
      w * 0.535,
      h * 0.738,
      w * 0.489,
      h * 0.809,
      w * 0.426,
      h * 0.861,
    );

    path.cubicTo(w * 0.267, h * 0.976, w * 0.058, h * 0.961, 0, h * 0.824);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> old) => false;
}
