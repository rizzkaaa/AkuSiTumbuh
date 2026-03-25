import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInput extends StatefulWidget {
  final String hint;
  final IconData icon;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const CustomInput({
    super.key,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.validator,
    required this.controller,
    this.keyboardType,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool isObscure = true;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            _buildTextField(),
            Positioned(
              left: 0,
              top: 0,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: const Color(0xFFD6A7C9),
                child: Icon(widget.icon, color: Colors.white, size: 27),
              ),
            ),
          ],
        ),

        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 6),
            child: Text(
              errorText!,
              style: GoogleFonts.libreCaslonText(
                fontSize: 12,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTextField() {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(left: 20),
      padding: const EdgeInsets.only(left: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.8),
            Colors.white.withValues(alpha: 0.1),
          ],
        ),
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword ? isObscure : false,
        style: GoogleFonts.libreCaslonText(
          fontSize: 16,
          color: const Color(0xFF9472C0),
        ),
        decoration: InputDecoration(
          hintText: widget.hint,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          hintStyle: GoogleFonts.libreCaslonText(
            fontSize: 16,
            color: const Color(0xFF9472C0).withValues(alpha: 0.5),
          ),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          errorStyle: const TextStyle(fontSize: 0, height: 0),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                    size: 17,
                  ),
                  onPressed: () => setState(() => isObscure = !isObscure),
                )
              : null,
        ),
        validator: (value) {
          final error = widget.validator?.call(value);
          Future.microtask(() {
            if (mounted) setState(() => errorText = error);
          });
          return error;
        },
      ),
    );
  }
}
