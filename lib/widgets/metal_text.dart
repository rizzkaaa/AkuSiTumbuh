import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MetalText extends StatelessWidget {
  final String text;
  final double? size;
  final TextAlign? textAlign;
  const MetalText({
    super.key,
    required this.text,
    this.size,
    this.textAlign = TextAlign.justify,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.metal(color: Color(0xFF5B5A5A), fontSize: size),
      textAlign: textAlign,
    );
  }
}
