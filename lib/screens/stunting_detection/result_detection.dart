import 'package:akusitumbuh/models/indicator_result_model.dart';
import 'package:akusitumbuh/widgets/gradient_border_button.dart';
import 'package:akusitumbuh/widgets/metal_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultDetection extends StatelessWidget {
  final Function(int) goToMenu;
  final List<int> resultList;

  ResultDetection({
    super.key,
    required this.resultList,
    required this.goToMenu,
  });

  final List<IndicatorResultModel> stuntingIndicators = [
    IndicatorResultModel(
      label: 'Normal',
      imgLabel: 'normal',
      warning: 'Bagus!',
      note:
          'Pertumbuhan anak berada pada kondisi normal. Tetap pantau pertumbuhannya secara rutin.',
      description:
          'Berdasarkan hasil pengukuran tinggi dan berat badan, pertumbuhan anak berada dalam kategori normal dan masih sesuai dengan usianya. Orang tua tetap disarankan untuk memantau pertumbuhan anak secara rutin serta memberikan asupan gizi yang seimbang agar tumbuh kembang anak tetap optimal.',
    ),
    IndicatorResultModel(
      label: 'Terdeteksi Stunting',
      imgLabel: 'already',
      warning: 'Perhatian!',
      note:
          'Pertumbuhan anak menunjukkan tanda stunting dan perlu penanganan lebih lanjut.',
      description:
          'Kondisi ini menunjukkan bahwa tinggi badan anak tidak sesuai dengan usianya. Orang tua disarankan memantau pertumbuhan anak secara rutin, memberikan asupan gizi seimbang, serta melakukan konsultasi dengan tenaga kesehatan agar mendapatkan penanganan yang tepat.',
    ),
    IndicatorResultModel(
      label: 'Stunting Berat',
      imgLabel: 'very',
      warning: 'Bahaya!',
      note:
          'Pertumbuhan anak menunjukkan kondisi stunting berat dan memerlukan penanganan segera.',
      description:
          'Hasil pemeriksaan menunjukkan bahwa tinggi badan anak berada jauh di bawah standar pertumbuhan sesuai dengan usianya. Kondisi ini menandakan adanya gangguan pada pertumbuhan yang perlu ditangani dengan serius. Orang tua disarankan untuk memantau pertumbuhan anak secara rutin, memberikan asupan gizi yang cukup dan seimbang, serta berkonsultasi dengan tenaga kesehatan agar anak mendapatkan penanganan yang tepat.',
    ),
  ];
  final List<IndicatorWeightModel> weightIndicators = [
    IndicatorWeightModel(
      label: 'Gizi Baik',
      imgLabel: 'already',
      warning: 'Bagus!',
      note:
          'Pertumbuhan anak sesuai dengan standar. Tinggi dan berat badan berada pada kisaran normal untuk usianya.',
    ),
    IndicatorWeightModel(
      label: 'Gizi Buruk',
      imgLabel: 'normal',
      warning: 'Perhatian!',
      note:
          'Berat badan anak lebih rendah dibanding tinggi badannya. Perlu peningkatan asupan gizi dan pemantauan lebih lanjut.',
    ),
    IndicatorWeightModel(
      label: 'Gizi Berlebih',
      imgLabel: 'very',
      warning: 'Perhatian!',
      note:
          'Berat badan anak melebihi proporsi ideal terhadap tinggi badannya. Perlu pengaturan pola makan dan aktivitas fisik.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final stuntingResult = resultList[0];
    final weightResult = resultList[1];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildStuntingResult(stuntingResult, weightResult),
        const SizedBox(height: 15),
        _buildWeightResult(weightResult),

        const SizedBox(height: 25),
        _buildExplanation(stuntingResult),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(10),
          child: GradientBorderButton(
            label: 'Rekomendasi Gizi',
            onTap: () => goToMenu(stuntingResult),
          ),
        ),
      ],
    );
  }

  Widget _buildIndicator(String imgLabel, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Image.asset(
            'assets/images/stunting-indicator/$imgLabel.png',
            width: 100,
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: GoogleFonts.kumarOne(
                color: Color(0xFFD6A7C9),
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNote(String warning, String note, bool isStuntingResult) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: isStuntingResult
              ? Border(left: BorderSide(color: Color(0xFFE3BCD1)))
              : Border(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFF92A6CD),
              ),
              child: Text(
                warning,
                style: GoogleFonts.moul(color: Color(0xFFF5DBEC)),
              ),
            ),
            MetalText(text: note),
          ],
        ),
      ),
    );
  }

  Widget _buildStuntingResult(int stuntingResult, int weightResult){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          _buildIndicator(
            stuntingIndicators[stuntingResult].imgLabel,
            '${stuntingIndicators[stuntingResult].label}\n${weightIndicators[weightResult].label}',
          ),
          _buildNote(
            stuntingIndicators[stuntingResult].warning,
            stuntingIndicators[stuntingResult].note,
            true,
          ),
        ],
      ),
    );
  }

  Widget _buildWeightResult(int weightResult) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          _buildNote(
            weightIndicators[weightResult].warning,
            weightIndicators[weightResult].note,
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildExplanation(int stuntingResult) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lebih lanjut; ',
          style: GoogleFonts.kumarOne(color: Color(0xFF3F5B8F), fontSize: 10),
        ),
        const SizedBox(height: 5),
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          child: MetalText(
            text: stuntingIndicators[stuntingResult].description,
          ),
        ),
      ],
    );
  }
}
