import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class RoleStep extends StatelessWidget {
  final String? selectedRole;
  final Function(String?) onChanged;

  const RoleStep({
    super.key,
    required this.selectedRole,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      key: ValueKey(0),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Daftar sebagai",
          style: GoogleFonts.abhayaLibre(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 201, 157, 188),
          ),
        ),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          initialValue: selectedRole,
          hint: Text(
            "Masuk sebagai",
            style: GoogleFonts.inriaSerif(
              color: Color(0xFFD6A7C9),
              fontSize: 16,
            ),
          ),

          icon: Icon(
            Icons.arrow_drop_down_circle_outlined,
            color: Color(0xFFD6A7C9),
          ),

          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withValues(alpha: 1),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),

            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),

          items: [
            DropdownMenuItem(
              value: 'Dokter Anak',
              child: Row(
                children: [
                  FaIcon(FontAwesomeIcons.userDoctor, color: Color(0xFFD6A7C9)),
                  SizedBox(width: 20),
                  Text(
                    'Dokter Anak',
                    style: GoogleFonts.inriaSerif(
                      color: Color(0xFFD6A7C9),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 'Orang Tua',
              child: Row(
                children: [
                  Icon(Icons.family_restroom, color: Color(0xFFD6A7C9)),
                  SizedBox(width: 20),
                  Text(
                    'Orang Tua',
                    style: GoogleFonts.inriaSerif(
                      color: Color(0xFFD6A7C9),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 'Puskesmas',
              child: Row(
                children: [
                  Icon(Icons.local_hospital, color: Color(0xFFD6A7C9)),
                  SizedBox(width: 20),
                  Text(
                    'Puskesmas',
                    style: GoogleFonts.inriaSerif(
                      color: Color(0xFFD6A7C9),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
          onChanged: onChanged,
        ),
      ],
    );
  }
}
