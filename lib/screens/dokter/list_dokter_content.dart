import 'package:akusitumbuh/extensions/extension.dart';
import 'package:akusitumbuh/models/dokter_anak_model.dart';
import 'package:akusitumbuh/screens/dokter/dokter_detail.dart';
import 'package:akusitumbuh/screens/dokter/search_field.dart';
import 'package:akusitumbuh/widgets/header_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListDokterContent extends StatefulWidget {
  const ListDokterContent({super.key});

  @override
  State<ListDokterContent> createState() => _ListDokterContentState();
}

class _ListDokterContentState extends State<ListDokterContent> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: HeaderText(label: 'Dokter Anak'),
            ),
            SearchField(
              controller: _searchController,
              onChanged: (value) {},
              onClear: () {},
            ),

            Expanded(
              child: Wrap(
                children: [
                  _buildCard(
                    DokterAnakModel(
                      fullname: 'dr. Aulia Rahmawati, Sp.A',
                      noSTR: '',
                      tempatPraktik: 'RSIA Bunda Jakarta',
                      jamMulai: TimeOfDay(hour: 8, minute: 0),
                      jamSelesai: TimeOfDay(hour: 15, minute: 0),
                      profile: '',
                      pengalaman: 0,
                      pendidikan: [],
                      keahlian: [],
                    ),
                    true,
                  ),
                  _buildCard(
                    DokterAnakModel(
                      fullname: 'dr. Aulia Rahmawati, Sp.A',
                      noSTR: '',
                      tempatPraktik: 'RSIA Bunda Jakarta',
                      jamMulai: TimeOfDay(hour: 8, minute: 0),
                      jamSelesai: TimeOfDay(hour: 15, minute: 0),
                      profile: '',
                      pengalaman: 0,
                      pendidikan: [],
                      keahlian: [],
                    ),
                    false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(DokterAnakModel dokter, bool isPink) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DokterDetail()),
      ),
      child: Container(
        width: 165,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isPink ? Color(0xFFD6A7C9) : Color(0xFF92A6CD),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 4,
              color: Colors.black.withValues(alpha: 0.25),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              isPink ? Color(0xFFF4D6E6) : Color(0xFFD6E1F4),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            Image.asset('assets/images/1.png', width: 132),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dokter.fullname,
                    style: GoogleFonts.libreBodoni(
                      fontWeight: FontWeight.bold,
                      fontSize: 8.5,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Color(0xFFF4B400), size: 10),
                      Text(
                        '4.9',
                        style: GoogleFonts.libreCaslonDisplay(fontSize: 9),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: isPink ? Color(0xFFD6A7C9) : Color(0xFF92A6CD)),
            Column(
              children: [
                Text(
                  'Tempat Praktik  :  ${dokter.tempatPraktik}',
                  style: GoogleFonts.nanumMyeongjo(
                    color: Color(0xFF686868),
                    fontSize: 7,
                  ),
                ),
                Text(
                  'Jam operasional : ${dokter.jamMulai.toHHmm()} s/d ${dokter.jamSelesai.toHHmm()} WIB',
                  style: GoogleFonts.nanumMyeongjo(
                    color: Color(0xFF686868),
                    fontSize: 7,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
