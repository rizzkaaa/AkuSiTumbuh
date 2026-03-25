import 'package:akusitumbuh/models/user_model.dart';
import 'package:akusitumbuh/screens/home/expansion_item.dart';
import 'package:akusitumbuh/screens/home/header_home.dart';
import 'package:akusitumbuh/models/education_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  List<EducationModel> _educations() {
    return [
      EducationModel(
        title: 'Apa itu Stunting?',
        icon: Icons.child_care,
        description:
            'Stunting adalah kondisi gagal tumbuh pada anak yang disebabkan oleh kekurangan gizi kronis dalam jangka waktu yang lama, terutama pada masa 1.000 hari pertama kehidupan. Anak yang mengalami stunting biasanya memiliki tinggi badan yang lebih rendah dibandingkan anak lain seusianya. Kondisi ini tidak hanya mempengaruhi pertumbuhan fisik, tetapi juga dapat berdampak pada perkembangan kognitif dan kesehatan anak di masa depan.',
      ),
      EducationModel(
        title: 'Penyebab Stunting',
        icon: Icons.search,
        description:
            'Stunting dapat disebabkan oleh beberapa faktor, antara lain:',
        items: [
          "Kekurangan asupan gizi yang cukup dalam jangka waktu lama",
          "Kurangnya asupan nutrisi pada ibu selama masa kehamilan",
          "Infeksi atau penyakit yang sering dialami anak",
          "Kurangnya pengetahuan orang tua tentang pola makan yang sehat",
          "Sanitasi dan kebersihan lingkungan yang kurang baik",
          "Kurangnya akses terhadap pelayanan kesehatan",
        ],
        note:
            'Faktor-faktor tersebut dapat mempengaruhi proses pertumbuhan anak sehingga meningkatkan risiko terjadinya stunting.',
      ),
      EducationModel(
        title: 'Dampak Stunting',
        icon: Icons.trending_down,
        description:
            'Stunting dapat memberikan dampak jangka pendek maupun jangka panjang terhadap kesehatan dan perkembangan anak, di antaranya:',
        items: [
          "Pertumbuhan fisik anak menjadi terhambat",
          "Perkembangan otak dan kemampuan belajar tidak optimal",
          "Daya tahan tubuh lebih rendah sehingga mudah terserang penyakit",
          "Risiko penyakit kronis meningkat saat dewasa",
          "Produktivitas dan kualitas hidup di masa depan dapat menurun",
        ],
        note:
            'Oleh karena itu, pencegahan dan deteksi stunting sejak dini sangat penting untuk memastikan anak dapat tumbuh dan berkembang secara optimal.',
      ),
      EducationModel(
        title: 'Cara Pencegahan Stunting',
        icon: Icons.shield,
        description:
            'Pencegahan stunting dapat dilakukan melalui beberapa langkah berikut:',
        items: [
          "Memastikan ibu hamil mendapatkan asupan gizi yang cukup dan seimbang",
          "Memberikan ASI eksklusif kepada bayi selama 6 bulan pertama",
          "Memberikan makanan pendamping ASI yang bergizi setelah usia 6 bulan",
          "Memantau pertumbuhan anak secara rutin di fasilitas kesehatan",
          "Menjaga kebersihan lingkungan dan sanitasi yang baik",
          "Melakukan imunisasi sesuai jadwal yang dianjurkan",
        ],
        note:
            'Dengan melakukan langkah-langkah tersebut, risiko terjadinya stunting pada anak dapat diminimalkan sehingga anak dapat tumbuh sehat dan optimal.',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          HeaderHome(currentUser: UserModel(docId: 'KDPXyanGtMVuO56jR3ibxVzIReu1', email: 'rizka@gmail.com', role: 'Orang Tua', photo: '', isNew: false),),
          const SizedBox(height: 40),
          Image.asset('assets/images/banner-home.png'),
          const SizedBox(height: 25),
          Text(
            'Edukasi',
            style: GoogleFonts.kumarOne(color: Color(0xFF3F5B8F), fontSize: 12),
          ),
          Expanded(
            child: ListView(
              children: _educations().asMap().entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ExpansionItem(index: entry.key, item: entry.value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
