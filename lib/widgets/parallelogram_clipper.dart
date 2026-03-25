import 'package:flutter/material.dart';
class ParallelogramClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(20, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width - 20, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}