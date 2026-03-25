import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FieldData extends StatelessWidget {
  final String label;
  final String? value;
  final bool isPwField;
  final double margin;
  final double width;

  const FieldData({
    super.key,
    required this.label,
    required this.width,
    this.value,
    this.isPwField = false,
    this.margin = 15
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.only(bottom: margin),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          _buildLabelText(label, width),
          const SizedBox(width: 10),
          isPwField
              ? Text(
                  '● ● ● ● ● ● ● ● ●',
                  style: TextStyle(color: Color(0xFFC198AD), fontSize: 20),
                )
              : Expanded(child: _buildInputText(value!)),
        ],
      ),
    );
  }

  Widget _buildLabelText(String label, double width){
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildLabelStyle(label), _buildLabelStyle(':')],
      ),
    );
  }

  Widget _buildLabelStyle(String text) {
    return Text(
      text,
      style: GoogleFonts.libreCaslonText(
        color: Color(0xFF96838D),
        fontWeight: FontWeight.w800,
        fontSize: 12,
      ),
    );
  }

  Widget _buildInputText(String text) {
    return Text(
      text,
      style: GoogleFonts.libreCaslonText(
        color: Color(0xFFC198AD),
        fontSize: 12,
      ),
    );
  }
}
