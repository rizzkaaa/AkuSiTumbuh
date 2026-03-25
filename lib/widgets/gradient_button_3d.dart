import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart' as inset;

class GradientButton3d extends StatelessWidget {
  final bool isLoading;
  final String text;
  final VoidCallback onPressed;

  const GradientButton3d({
    super.key,
    required this.isLoading,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: inset.BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Color(0xFFB7C8E8), Color(0xFFF5B6D7)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            inset.BoxShadow(
              color: Color(0xFF92A7CD),
              blurRadius: 4,
              offset: Offset(4, -4),
              inset: true,
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Text(
                  text,
                  style: GoogleFonts.lateef(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
        ),
      ),
    );
  }
}
