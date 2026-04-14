import 'package:akusitumbuh/screens/dokter/payment_screen.dart';
import 'package:akusitumbuh/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DemandBanner extends StatelessWidget {
  final String dokterID;
  DemandBanner({super.key, required this.dokterID});

  final List<String> fitur = [
    "✓ Konsultasi pribadi dengan dokter anak",
    "✓ Chat langsung dengan dokter",
    "✓ Konsultasi online mudah dan praktis",
    "✓ Rekomendasi kesehatan dan nutrisi anak",
    "✓ Riwayat chat dan konsultasi tersimpan",
    "✓ Bisa bertanya kembali kepada dokter",
  ];

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: Offset(0, -20),
                    child: Text(
                      'Rp',
                      style: GoogleFonts.libreCaslonText(fontSize: 15),
                    ),
                  ),
                  Text(
                    '50.000,00',
                    style: GoogleFonts.libreCaslonText(fontSize: 30),
                  ),

                  Transform.translate(
                    offset: Offset(0, 10),
                    child: Text(
                      '/bulan',
                      style: GoogleFonts.libreCaslonText(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Divider(thickness: 1, color: Color(0xFF686868)),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: fitur
                    .map(
                      (e) => Text(
                        e,
                        style: GoogleFonts.nanumMyeongjo(
                          color: Color(0xFF686868),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 28),

              GradientButton(
                label: 'Beli',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(dokterID: dokterID),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
