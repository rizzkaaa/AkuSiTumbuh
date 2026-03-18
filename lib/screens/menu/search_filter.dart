import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchFilter extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback onClear;
  final VoidCallback onFiltered;

  const SearchFilter({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
    required this.onFiltered,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildSearchForm(),
        const SizedBox(width: 20),
        _buildFilterButton(),
      ],
    );
  }

  Widget _buildSearchForm() {
    return Expanded(
      child: Container(
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
              'Cari lebih banyak',
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
      ),
    );
  }

  Widget _buildFilterButton() {
    return ElevatedButton(
      onPressed: onFiltered,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFD6A7C9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
      ),
      child: Icon(Icons.tune, color: Color(0xFFFFEAF5), size: 30),
    );
  }
}
