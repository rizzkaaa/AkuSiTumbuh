import 'package:akusitumbuh/widgets/gradient_border_button.dart';
import 'package:akusitumbuh/widgets/gradient_button.dart';
import 'package:akusitumbuh/widgets/metal_text.dart';
import 'package:flutter/material.dart';

class DemandBanner extends StatelessWidget {
  const DemandBanner({super.key});

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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Keluar dari akun?'),
              MetalText(
                text: 'Kamu perlu login kembali untuk mengakses aplikasi.',
              ),
              Row(
                children: [
                  GradientBorderButton(
                    label: 'Batal',
                    onTap: () => Navigator.pop(context),
                  ),
                  GradientButton(label: 'Keluar', onTap: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
