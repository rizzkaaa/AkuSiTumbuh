import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback onClear;

  const SearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.3),
        border: Border.all(color: Color(0xFFD6A7C9), width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: Color(0xFFE3BCD1),
        style: GoogleFonts.inriaSerif(color: Color(0xFFD6A7C9), fontSize: 16),
        decoration: InputDecoration(
          hint: Text(
            'Cari Dokter anak pilihanmu',
            style: GoogleFonts.inriaSerif(
              color: Color(0xFFD6A7C9),
              fontSize: 16,
            ),
          ),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.zero,
          icon: IconButton(
            onPressed: onClear,
            icon: Icon(
              controller.text.isEmpty ? Icons.search : Icons.close,
              color: Color(0xFFE3BCD1),
              fontWeight: FontWeight.bold,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
