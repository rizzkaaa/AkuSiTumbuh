import 'package:akusitumbuh/models/dokter_anak_model.dart';
import 'package:akusitumbuh/widgets/dokter/state_0.dart';
import 'package:akusitumbuh/widgets/dokter/state_1.dart';
import 'package:akusitumbuh/widgets/dokter/state_2.dart';
import 'package:akusitumbuh/widgets/dokter/state_3.dart';
import 'package:flutter/material.dart';

import 'package:akusitumbuh/services/auth_service.dart';
import 'package:akusitumbuh/widgets/gradient_button_3d.dart';
import 'package:google_fonts/google_fonts.dart';

class EditDokter extends StatefulWidget {
  final DokterAnakModel dokterAnak;
  const EditDokter({super.key, required this.dokterAnak});

  @override
  State<EditDokter> createState() => _EditDokterState();
}

class _EditDokterState extends State<EditDokter> {
  final AuthService _service = AuthService();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController strController = TextEditingController();
  final TextEditingController praktikController = TextEditingController();
  final TextEditingController profileController = TextEditingController();
  final TextEditingController pengalamanController = TextEditingController();
  List<TextEditingController> pendidikanControllers = [TextEditingController()];
  int pasien = 0;
  List<String?> keahlian = [null];
  TimeOfDay? jamMulai;
  TimeOfDay? jamSelesai;

  int currentState = 0;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final data = widget.dokterAnak;
    namaController.text = data.fullname;
    strController.text = data.noSTR;
    praktikController.text = data.tempatPraktik;
    jamMulai = data.jamMulai;
    jamSelesai = data.jamSelesai;
    profileController.text = data.profile;
    pengalamanController.text = '${data.pengalaman}';
    pasien = data.pasien;
    pendidikanControllers = data.pendidikan
        .map((e) => TextEditingController(text: e))
        .toList();

    keahlian = List<String?>.from(data.keahlian);
  }

  @override
  void dispose() {
    namaController.dispose();
    strController.dispose();
    praktikController.dispose();
    profileController.dispose();
    pengalamanController.dispose();

    for (var controller in pendidikanControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final result = await _service.updateProfile(
        role: 'Dokter Anak',
        dokterAnak: DokterAnakModel(
          fullname: namaController.text,
          noSTR: strController.text,
          tempatPraktik: praktikController.text,
          jamMulai: jamMulai!,
          jamSelesai: jamSelesai!,
          profile: profileController.text,
          pasien: pasien,
          pengalaman: int.parse(pengalamanController.text),
          pendidikan: pendidikanControllers.map((e) => e.text).toList(),
          keahlian: keahlian.map((e) => e!).toList(),
        ),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result ?? "Edit berhasil",
              style: GoogleFonts.inriaSerif(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 164, 183, 214),
          ),
        );

        setState(() => isLoading = false);

        if (result == null) {
          Navigator.pop(context, true);
        } else {
          Navigator.pop(context, false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Form(
          key: _formKey,
          child: Column(
            children: [
              if (currentState == 0) _buildState0(),
              if (currentState == 1) _buildState1(),
              if (currentState == 2) _buildState2(),
              if (currentState == 3) _buildState3(),

              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: GradientButton3d(
                  isLoading: isLoading,
                  text: currentState == 3 ? 'Simpan' : 'Next',
                  onPressed: () {
                    if (currentState == 0 &&
                        (namaController.text.trim().isEmpty ||
                            strController.text.trim().isEmpty ||
                            praktikController.text.trim().isEmpty ||
                            jamMulai == null ||
                            jamSelesai == null)) {
                      return;
                    }

                    if (currentState == 1 &&
                        (profileController.text.trim().isEmpty ||
                            pengalamanController.text.trim().isEmpty ||
                            int.parse(pengalamanController.text) <= 0)) {
                      return;
                    }
                    if (currentState == 2) {
                      for (var controller in pendidikanControllers) {
                        if (controller.text.isEmpty) return;
                      }
                    }

                    if (currentState == 3) {
                      for (var k in keahlian) {
                        if (k == null) return;
                      }
                      _handleSubmit();
                      return;
                    }

                    setState(() {
                      currentState++;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildState0() {
    return State0(
      namaController: namaController,
      strController: strController,
      praktikController: praktikController,
      jamMulai: jamMulai,
      jamSelesai: jamSelesai,
      voidJamMulai: (time) {
        setState(() => jamMulai = time);
      },
      voidJamSelesai: (time) {
        if (jamMulai != null) {
          final mulai = jamMulai!.hour * 60 + jamMulai!.minute;
          final selesai = time.hour * 60 + time.minute;
          if (selesai <= mulai) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Jam selesai harus lebih dari jam mulai!'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
        }
        setState(() => jamSelesai = time);
      },
    );
  }

  Widget _buildState1() {
    return State1(
      profileController: profileController,
      pengalamanController: pengalamanController,
    );
  }

  Widget _buildState2() {
    return State2(pendidikanControllers: pendidikanControllers);
  }

  Widget _buildState3() {
    return State3(keahlian: keahlian);
  }
}
