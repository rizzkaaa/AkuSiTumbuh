import 'package:akusitumbuh/extensions/extension.dart';
import 'package:akusitumbuh/models/dokter_anak_model.dart';
import 'package:akusitumbuh/models/user_model.dart';
import 'package:akusitumbuh/screens/dokter/dokter_detail.dart';
import 'package:akusitumbuh/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardDokter extends StatefulWidget {
  final DokterAnakModel dokter;
  final bool isPink;
  const CardDokter({super.key, required this.dokter, required this.isPink});

  @override
  State<CardDokter> createState() => _CardDokterState();
}

class _CardDokterState extends State<CardDokter> {
  final AuthService _service = AuthService();
  late Future<UserModel> dokterData;

  @override
  void initState() {
    super.initState();
    dokterData = _service.getPhotoDokter(widget.dokter.docId!);
  }

  @override
  Widget build(BuildContext context) {
    final dokter = widget.dokter;
    final isPink = widget.isPink;
    return
    
    Container(
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
          FutureBuilder(
            future: dokterData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Image(
                  image: AssetImage(
                    'assets/images/default-ava-${isPink ? 'pink' : 'blue'}.png',
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else {
                final data = snapshot.data!;

                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DokterDetail(
                        dokter: dokter,
                        isPink: isPink,
                        photo: data.photo,
                      ),
                    ),
                  ),
                  child: Image(
                    image: (data.photo.toString().isNotEmpty)
                        ? data.photo.toImageProvider()
                        : AssetImage(
                            'assets/images/default-ava-${isPink ? 'pink' : 'blue'}.png',
                          ),
                    width: 132,
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    dokter.fullname,
                    style: GoogleFonts.libreBodoni(
                      fontWeight: FontWeight.bold,
                      fontSize: 8.5,
                    ),
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
      // ),
      // );
      //   }
      // },
    );
  }
}
