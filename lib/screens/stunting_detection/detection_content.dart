import 'package:akusitumbuh/screens/stunting_detection/form_deteksi.dart';
import 'package:akusitumbuh/screens/stunting_detection/result_detection.dart';
import 'package:akusitumbuh/widgets/header_text.dart';
import 'package:akusitumbuh/widgets/metal_text.dart';
import 'package:flutter/material.dart';

class DetectionContent extends StatefulWidget {
  final Function(int) goToMenu;
  const DetectionContent({super.key, required this.goToMenu});

  @override
  State<DetectionContent> createState() => _DetectionContentState();
}

class _DetectionContentState extends State<DetectionContent> {
  int indexResult = -1;
  List<int> resultList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderText(label: "Deteksi Stunting"),

            Expanded(
              child: ListView(
                children: [
                  _buildBanner(),
                  const SizedBox(height: 20),
                  _buildFormDetection(),
                  const SizedBox(height: 20),
                  if (resultList.isNotEmpty) _buildExplanation(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
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
    );
  }

  Widget _buildFormDetection() {
    return Container(
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
          colors: [Color(0xFFCCDDFB), Color(0xFFFBDDED)],
        ),
      ),
      child: FormDeteksi(
        showResult: (result) {
          setState(() {
            // indexResult = result;
            resultList = result;
          });
        },
      ),
    );
  }

  Widget _buildExplanation() {
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
          border: Border.symmetric(
            vertical: BorderSide(color: Color(0xFFD6A7C9), width: 4),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF5B6D7), Color(0xFFB7C8E8)],
          ),
        ),
        child: ResultDetection(
          resultList: resultList,
          goToMenu: widget.goToMenu,
        ),
    );
  }
}
