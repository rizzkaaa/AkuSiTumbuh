import 'package:akusitumbuh/screens/auth/input_form.dart';
import 'package:flutter/material.dart';

class State1 extends StatelessWidget {
  final TextEditingController profileController;
  final TextEditingController pengalamanController;
  const State1({
    super.key,
    required this.profileController,
    required this.pengalamanController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputForm(
          hint: 'Profil',
          controller: profileController,
          maxLine: 5,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Beri sedikit deskripsi diri Anda";
            }
            return null;
          },
        ),
        const SizedBox(height: 20),

        InputForm(
          hint: 'Pengalaman',
          controller: pengalamanController,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Masukkan berapa tahun pengalaman Anda";
            }
            return null;
          },
        ),
      ],
    );
  }
}
