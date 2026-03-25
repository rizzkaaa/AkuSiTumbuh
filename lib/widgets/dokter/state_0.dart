import 'package:akusitumbuh/screens/auth/input_form.dart';
import 'package:akusitumbuh/screens/auth/time_input.dart';
import 'package:flutter/material.dart';

class State0 extends StatelessWidget {
  final TextEditingController namaController;
  final TextEditingController strController;
  final TextEditingController praktikController;
  final Function(TimeOfDay) voidJamMulai;
  final Function(TimeOfDay) voidJamSelesai;
  final TimeOfDay? jamMulai;
  final TimeOfDay? jamSelesai;

  const State0({
    super.key,
    required this.namaController,
    required this.strController,
    required this.praktikController,
    required this.voidJamMulai,
    required this.voidJamSelesai,
    this.jamMulai,
    this.jamSelesai,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputForm(
          hint: "Nama lengkap",
          controller: namaController,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Masukkan nama lengkap Anda";
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        InputForm(
          hint: 'Nomor STR',
          controller: strController,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Masukkan nomor STR";
            }
            if (value.length < 10) {
              return "Nomor STR tidak valid";
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        InputForm(
          hint: 'Tempat praktik',
          controller: praktikController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Masukkan nama tempat Anda praktik";
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        _buildJamKerja(),
      ],
    );
  }

  Widget _buildJamKerja() {
    return Row(
      children: [
        Expanded(
          child: TimeInput(
            hint: 'Jam mulai',
            initialTime: jamMulai,
            onTimeSelected: voidJamMulai,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TimeInput(
            hint: 'Jam selesai',
            initialTime: jamSelesai,
            onTimeSelected: voidJamSelesai,
          ),
        ),
      ],
    );
  }
}
