import 'package:akusitumbuh/screens/stunting_detection/form_deteksi.dart';
import 'package:akusitumbuh/screens/stunting_detection/result_detection.dart';
import 'package:akusitumbuh/widgets/metal_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetectionContent extends StatefulWidget {
  const DetectionContent({super.key});

  @override
  State<DetectionContent> createState() => _DetectionContentState();
}

class _DetectionContentState extends State<DetectionContent> {
  int indexResult = -1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Text(
                  "Deteksi Stunting",
                  style: GoogleFonts.jomhuria(
                    wordSpacing: 2,
                    letterSpacing: 1.5,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 5
                      ..color = Color(0xFFCEAABD),
                  ),
                ),
                Text(
                  "Deteksi Stunting",
                  style: GoogleFonts.jomhuria(
                    wordSpacing: 2,
                    letterSpacing: 1.5,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFFD6A7C9)),
              ),
              child: MetalText(
                text:
                    '“Deteksi stunting sejak dini sangat penting untuk memantau pertumbuhan dan perkembangan anak. Dengan melakukan pengecekan tinggi badan dan berat badan secara berkala, orang tua dapat mengetahui kondisi pertumbuhan anak serta mencegah risiko stunting sedini mungkin.”',
              ),
            ),

            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
                border: Border.symmetric(
                  vertical: BorderSide(color: Color(0xFFD6A7C9), width: 4),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFB7C8E8), Color(0xFFF5B6D7)],
                ),
              ),
              child: FormDeteksi(
                showResult: (result) {
                  setState(() {
                    indexResult = result;
                  });
                },
              ),
            ),

            const SizedBox(height: 20),

            if (indexResult > -1)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                    border: Border.symmetric(
                      vertical: BorderSide(color: Color(0xFFD6A7C9), width: 4),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFF5B6D7), Color(0xFFB7C8E8)],
                    ),
                  ),
                  child: ResultDetection(indexResult: indexResult),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
