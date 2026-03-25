import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          'Tumbi',
          style: GoogleFonts.lilitaOne(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 5
              ..color = Color(0xFFDC8DB7),
          ),
        ),
        Text(
          'Tumbi',
          style: GoogleFonts.lilitaOne(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
