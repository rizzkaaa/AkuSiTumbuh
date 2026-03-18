import 'dart:math';

import 'package:akusitumbuh/services/stunting_checking_service.dart';
import 'package:akusitumbuh/widgets/gradient_border_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormDeteksi extends StatefulWidget {
  final Function(int) showResult;
  const FormDeteksi({super.key, required this.showResult});

  @override
  State<FormDeteksi> createState() => _FormDeteksiState();
}

class _FormDeteksiState extends State<FormDeteksi> {
  final TextEditingController tbController = TextEditingController();
  final TextEditingController bbController = TextEditingController();

  int ageInMonths(DateTime birthDate) {
    DateTime now = DateTime.now();

    int months =
        (now.year - birthDate.year) * 12 + (now.month - birthDate.month);

    if (now.day < birthDate.day) {
      months--;
    }

    return months;
  }

  double calculateZScore(double height, int L, double M, double S) {
    return (pow((height / M), L) - 1) / (L * S);
  }

  Future<int> checkStunting() async {
    FocusScope.of(context).unfocus();
    if (tbController.text.isEmpty || bbController.text.isEmpty) return -1;

    final birthDate = DateTime(2023, 3, 17);
    final gender = 'boy';

    StuntingCheckingService service = StuntingCheckingService();
    var result = service.getData(gender, ageInMonths(birthDate));

    final X = double.parse(tbController.text);
    final L = result.L;
    final M = result.M;
    final S = result.S;

    final Z = calculateZScore(X, L, M, S);

    int indexResult = -1;

    if (Z >= -2) {
      indexResult = 0; // normal
    } else if (Z >= -3) {
      indexResult = 1; // stunting
    } else {
      indexResult = 2; // stunting berat
    }

    widget.showResult(indexResult);
    return indexResult;
  }

  @override
  void dispose() {
    tbController.dispose();
    bbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTextField(
              label: 'Tinggi Badan',
              controller: tbController,
              satuan: '(cm)',
            ),
            _buildTextField(
              label: 'Berat Badan',
              controller: bbController,
              satuan: '(kg)',
            ),
          ],
        ),
        const SizedBox(height: 20),
        GradientBorderButton(label: 'Cek Stunting', onTap: checkStunting),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String satuan,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.libreBodoni(color: Color(0xFF3F5B8F))),
        const SizedBox(height: 5),
        Container(
          width: 130,
          padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xFF92A6CD), width: 2),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  cursorHeight: 25,
                  cursorColor: Color(0xFFF5B6D7),
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  controller: controller,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF92A6CD)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF92A6CD),
                        width: 2,
                      ),
                    ),
                    counterText: "",
                    contentPadding: EdgeInsets.zero,
                    constraints: BoxConstraints(maxHeight: 40),
                  ),
                  style: GoogleFonts.lateef(
                    color: Color(0xFF3F5B8F),
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 15),
              Text(
                satuan,
                style: GoogleFonts.lateef(
                  color: Color(0xFF92A6CD),
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
