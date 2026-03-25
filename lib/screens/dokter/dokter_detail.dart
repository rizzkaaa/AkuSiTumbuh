import 'package:akusitumbuh/screens/dokter/demand_banner.dart';
import 'package:akusitumbuh/screens/dokter/ratting_dialog.dart';
import 'package:akusitumbuh/widgets/custom_back_button.dart';
import 'package:akusitumbuh/widgets/gradient_border_button.dart';
import 'package:akusitumbuh/widgets/gradient_button.dart';
import 'package:akusitumbuh/widgets/metal_text.dart';
import 'package:akusitumbuh/widgets/unordered_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart' as inset;

class DokterDetail extends StatefulWidget {
  const DokterDetail({super.key});

  @override
  State<DokterDetail> createState() => _DokterDetailState();
}

class _DokterDetailState extends State<DokterDetail> {
  final List pendidikan = [
    'S1 Kedokteran - Universitas Indonesia',
    'Spesialis Anak (Sp.A) - Universitas Indonesia',
  ];

  final List keahlian = [
    'Konsultasi kesehatan anak dan remaja',
    'Imunisasi',
    'Edukasi kesehatan keluarga',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xFFD6A7C9), Colors.white, Color(0xFFD6A7C9)],
                stops: [0.1, 0.3, 1],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                CustomBackButton(),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'dr. Aulia Rahmawati, Sp.A',
                                  style: GoogleFonts.libreBodoni(
                                    color: Color(0xFF996781),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 2.5,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2.5,
                                    horizontal: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: MetalText(text: 'RSIA Bunda Jakarta'),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 2.5,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2.5,
                                    horizontal: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: MetalText(text: '08.00 - 16.00 WIB'),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Transform.translate(
                              offset: Offset(0, 10),
                              child: Image.asset('assets/images/1.png'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border(
                        top: BorderSide(color: Color(0xFFD6A7C9), width: 5),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildCard(
                              Icons.work_outlined,
                              '5 Tahun',
                              'Pengalaman',
                            ),
                            _buildCard(
                              Icons.people_alt_rounded,
                              '400',
                              'Pasien',
                            ),
                            _buildCard(Icons.star, '1K', 'Rating'),
                          ],
                        ),
                        _buildBoxExplanation(
                          label: 'Profil',
                          children: MetalText(
                            text:
                                'dr. Fadli memiliki pengalaman dalam bidang kesehatan anak dan remaja. Ia sering membantu orang tua dalam memahami kondisi kesehatan anak serta memberikan penanganan yang tepat.',
                          ),
                        ),
                        _buildBoxExplanation(
                          label: 'Pendidikan',
                          children: Column(
                            children: pendidikan
                                .map((item) => UnorderedList(text: item))
                                .toList(),
                          ),
                        ),
                        _buildBoxExplanation(
                          label: 'Keahlian',
                          children: Column(
                            children: keahlian
                                .map((item) => UnorderedList(text: item))
                                .toList(),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GradientBorderButton(
                              label: 'Rating',
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierColor: Colors.black.withValues(
                                    alpha: 0.3,
                                  ),
                                  builder: (_) => const RattingDialog(),
                                );
                              },
                            ),
                            GradientButton(
                              label: 'Konsultasi',
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierColor: Colors.black.withValues(
                                    alpha: 0.3,
                                  ),
                                  builder: (_) => DemandBanner(),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(IconData icon, String value, String label) {
    return Container(
      height: 100,
      width: 100,
      padding: const EdgeInsets.all(10),
      decoration: inset.BoxDecoration(
        boxShadow: [
          inset.BoxShadow(
            color: Color(0xFFD6A7C9).withValues(alpha: 0.7),
            offset: Offset(0, 1),
            blurRadius: 20,
            inset: true,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Color(0xFFD6A7C9), size: 40),
          Text(
            value,
            style: GoogleFonts.nanumMyeongjo(
              color: Color(0xFF686868),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.nanumMyeongjo(
              color: Color(0xFF686868),
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoxExplanation({
    required String label,
    required Widget children,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.kumarOne(
              color: Color(0xFF996781),
              // color: pink ? Color(0xFF996781) : Color(0xFF677899),
              fontSize: 12,
            ),
          ),
          children,
        ],
      ),
    );
  }
}
