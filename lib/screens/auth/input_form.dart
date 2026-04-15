import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class InputForm extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final int maxLine;
  

  const InputForm({
    super.key,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.suffixIcon,
    this.validator,
    this.obscureText = false,
    this.maxLine = 1
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      obscureText: obscureText,
      style: GoogleFonts.libreCaslonText(
        fontSize: 16,
        color: const Color(0xFF9472C0),
      ), 
      maxLines: maxLine,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffixIcon,
        suffixIconColor: Color(0xFFD6A7C9),
        hintStyle: GoogleFonts.inriaSerif(
          color: Color(0xFF9472C0).withValues(alpha: 0.5),
          fontSize: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD6A7C9)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD6A7C9)),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
