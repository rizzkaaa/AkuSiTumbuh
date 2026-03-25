import 'package:akusitumbuh/extensions/extension.dart';
import 'package:akusitumbuh/models/dokter_anak_model.dart';
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
  final DokterAnakModel dokter;
  final String photo;
  final bool isPink;
  const DokterDetail({
    super.key,
    required this.dokter,
    required this.photo,
    required this.isPink,
  });

  @override
  State<DokterDetail> createState() => _DokterDetailState();
}

class _DokterDetailState extends State<DokterDetail> {
  @override
  Widget build(BuildContext context) {
    final dokter = widget.dokter;
    final isPink = widget.isPink;
    final photo = widget.photo;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  isPink
                      ? isPink
                            ? Color(0xFFD6A7C9)
                            : Color(0xFF92A6CD)
                      : Color(0xFF92A6CD),
                  Colors.white,
                  isPink ? Color(0xFFD6A7C9) : Color(0xFF92A6CD),
                ],
                stops: [0.1, 0.3, 1],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                CustomBackButton(),
                _buildHeadSection(dokter, photo, isPink),

                _buildMainSection(dokter, isPink),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(IconData icon, String value, String label, bool isPink) {
    return Container(
      height: 100,
      width: 100,
      padding: const EdgeInsets.all(10),
      decoration: inset.BoxDecoration(
        boxShadow: [
          inset.BoxShadow(
            color: isPink
                ? Color(0xFFD6A7C9)
                : Color(0xFF92A6CD).withValues(alpha: 0.7),
            offset: Offset(0, 1),
            blurRadius: 20,
            inset: true,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: isPink ? Color(0xFFD6A7C9) : Color(0xFF92A6CD),
            size: 40,
          ),
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
    required bool isPink
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.kumarOne(
              color: isPink ? Color(0xFF996781) : Color(0xFF677899),
              fontSize: 12,
            ),
          ),
          children,
        ],
      ),
    );
  }

  Widget _buildHeadSection(DokterAnakModel dokter, String photo, bool isPink) {
    return Padding(
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
                      dokter.fullname,
                      style: GoogleFonts.libreBodoni(
                        color: isPink ? Color(0xFF996781) : Color(0xFF677899),
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 2.5),
                      padding: const EdgeInsets.symmetric(
                        vertical: 2.5,
                        horizontal: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: MetalText(text: dokter.tempatPraktik),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 2.5),
                      padding: const EdgeInsets.symmetric(
                        vertical: 2.5,
                        horizontal: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: MetalText(
                        text:
                            '${dokter.jamMulai.toHHmm()} - ${dokter.jamSelesai.toHHmm()} WIB',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Transform.translate(
                  offset: Offset(0, 10),
                  child: Image(
                    image: (photo.toString().isNotEmpty)
                        ? photo.toImageProvider()
                        : const AssetImage('assets/images/default-profile.png'),
                    width: 132,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainSection(DokterAnakModel dokter, bool isPink) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border(
            top: BorderSide(
              color: isPink ? Color(0xFFD6A7C9) : Color(0xFF92A6CD),
              width: 5,
            ),
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
                  '${dokter.pengalaman} Tahun',
                  'Pengalaman',
                  isPink,
                ),
                _buildCard(
                  Icons.people_alt_rounded,
                  dokter.pasien.toString(),
                  'Pasien',
                  isPink,
                ),
                _buildCard(Icons.star, '1K', 'Rating', isPink),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildBoxExplanation(
                    label: 'Profil',
                    children: MetalText(text: dokter.profile),
                    isPink: isPink
                  ),
                  _buildBoxExplanation(
                    label: 'Pendidikan',
                    children: Column(
                      children: dokter.pendidikan
                          .map((item) => UnorderedList(text: item))
                          .toList(),
                    ),
                    isPink: isPink
                  ),
                  _buildBoxExplanation(
                    label: 'Keahlian',
                    children: Column(
                      children: dokter.keahlian
                          .map((item) => UnorderedList(text: item))
                          .toList(),
                    ),
                    isPink: isPink
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
                            barrierColor: Colors.black.withValues(alpha: 0.3),
                            builder: (_) => const RattingDialog(),
                          );
                        },
                      ),
                      GradientButton(
                        label: 'Konsultasi',
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierColor: Colors.black.withValues(alpha: 0.3),
                            builder: (_) => DemandBanner(),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
