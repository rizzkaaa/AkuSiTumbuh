import 'package:akusitumbuh/widgets/gradient_border_button.dart';
import 'package:akusitumbuh/widgets/gradient_button.dart';
import 'package:akusitumbuh/widgets/metal_text.dart';
import 'package:flutter/material.dart';
import 'package:akusitumbuh/screens/auth/login_page.dart';
import 'package:akusitumbuh/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoutAlert extends StatelessWidget {
  LogoutAlert({super.key});
  final AuthService _service = AuthService();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Color(0xFF92A7CD), Color(0xFFFFC9E6)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: Offset(5, 10),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Keluar dari akun?',
                style: GoogleFonts.libreBodoni(
                  color: Color(0xFF996781),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              MetalText(
                text: 'Kamu perlu login kembali untuk mengakses aplikasi.',
                textAlign: TextAlign.center,
                size: 16,
              ),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GradientBorderButton(
                    label: 'Batal',
                    onTap: () => Navigator.pop(context),
                  ),
                  GradientButton(
                    label: 'Keluar',
                    onTap: () async {
                      await _service.logout();
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
