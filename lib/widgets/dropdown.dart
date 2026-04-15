import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dropdown extends StatelessWidget {
  final String? selectedValue;
  final Function(String?) onChanged;
  final List<String> items;
  final String label;

  const Dropdown({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    required this.label,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedValue,
      hint: Text(
        label,
        style: GoogleFonts.inriaSerif(color: Color(0xFFD6A7C9), fontSize: 16),
      ),

      icon: Icon(
        Icons.arrow_drop_down_circle_outlined,
        color: Color(0xFFD6A7C9),
      ),

      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 1),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD6A7C9)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD6A7C9)),
        ),
      ),

      items: items
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.inriaSerif(
                  color: Color(0xFF9472C0),
                  fontSize: 16,
                ),
              ),
            ),
          )
          .toList(),

      onChanged: onChanged,
    );
  }
}
