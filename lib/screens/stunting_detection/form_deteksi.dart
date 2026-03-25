import 'package:akusitumbuh/services/stunting_checking_service.dart';
import 'package:akusitumbuh/widgets/gradient_border_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormDeteksi extends StatefulWidget {
  final Function(List<int>) showResult;
  const FormDeteksi({super.key, required this.showResult});

  @override
  State<FormDeteksi> createState() => _FormDeteksiState();
}

class _FormDeteksiState extends State<FormDeteksi> {
  final StuntingCheckingService _service = StuntingCheckingService();
  final TextEditingController tbController = TextEditingController();
  final TextEditingController bbController = TextEditingController();
  bool isLoading = false;
  bool isDone = false;
  String alert = '';

  void checkStunting() async {
    if (isLoading || isDone) return;
    FocusScope.of(context).unfocus();
    if (tbController.text.isEmpty || bbController.text.isEmpty) {
      setState(() {
        alert = 'Silakan isi tinggi dan berat badan anak';
      });
      return;
    }

    setState(() => isLoading = true);

    final tb = double.parse(tbController.text);
    final bb = double.parse(bbController.text);

    if (tb < bb) {
      setState(() {
        alert = 'Tinggi dan berat badan tidak valid';
      });
      return;
    }
    if (tb < 65 || tb > 120) {
      setState(() {
        alert = 'Tinggi harus berkisar antara 65-120cm';
      });
      return;
    }

    setState(() {
      alert = '';
    });

    final stuntingResult = await _service.checkStunting(tb, bb);

    if (stuntingResult == -1) {
      setState(() {
        alert = 'Usia anak tidak memenuhi';
      });
      return;
    }

    final weightResult = await _service.checkWeight(tb, bb);
    widget.showResult([stuntingResult, weightResult]);
    setState(() {
      isLoading = false;
      isDone = true;
    });
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
        const SizedBox(height: 10),
        if (alert.isNotEmpty) _buildAlert(alert),
        const SizedBox(height: 10),
        GradientBorderButton(
          label: 'Cek Stunting',
          onTap: checkStunting,
          isLoading: isLoading,
        ),
      ],
    );
  }

  Widget _buildAlert(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.warning_amber_rounded, color: Colors.red),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.metal(color: Colors.red, fontSize: 17),
          ),
        ),
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
