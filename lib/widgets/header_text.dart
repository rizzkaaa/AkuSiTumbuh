import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderText extends StatelessWidget {
  final String label;
  const HeaderText({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          label,
          style: GoogleFonts.jomhuria(
            wordSpacing: 2,
            letterSpacing: 1.5,
            fontSize: 50,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 5
              ..color = Color(0xFFCEAABD),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.jomhuria(
            wordSpacing: 2,
            letterSpacing: 1.5,
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
