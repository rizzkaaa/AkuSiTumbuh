import 'package:akusitumbuh/models/dokter_anak_model.dart';
import 'package:akusitumbuh/screens/auth/login_page.dart';
import 'package:akusitumbuh/services/auth_service.dart';
import 'package:akusitumbuh/widgets/dokter/state_0.dart';
import 'package:akusitumbuh/widgets/dokter/state_1.dart';
import 'package:akusitumbuh/widgets/dokter/state_2.dart';
import 'package:akusitumbuh/widgets/dokter/state_3.dart';
import 'package:akusitumbuh/widgets/gradient_button_3d.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormDokter extends StatefulWidget {
  final Function(VoidCallback) onBack;
  final String email;
  final String password;

  const FormDokter({
    super.key,
    required this.email,
    required this.password,
    required this.onBack,
  });

  @override
  State<FormDokter> createState() => _FormDokterState();
}

class _FormDokterState extends State<FormDokter> {
  final AuthService _service = AuthService();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController strController = TextEditingController();
  final TextEditingController praktikController = TextEditingController();
  final TextEditingController profileController = TextEditingController();
  final TextEditingController pengalamanController = TextEditingController();
  List<TextEditingController> pendidikanControllers = [TextEditingController()];
  List<String?> keahlian = [null];
  TimeOfDay? jamMulai;
  TimeOfDay? jamSelesai;

  int currentState = 0;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  List<String> keahlianDokter = [
    "Tumbuh kembang anak",
    "Imunisasi",
    "Nutrisi anak",
    "MPASI",
    "Alergi anak",
    "Infeksi anak",
    "Konsultasi bayi baru lahir",
    "Keterlambatan perkembangan",
    "Gangguan makan anak",
    "Parenting kesehatan anak",
  ];

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
      final email = widget.email;
      final password = widget.password;

      final result = await _service.register(
        email: email,
        password: password,
        role: 'Dokter Anak',
        dokterAnak: DokterAnakModel(
          fullname: namaController.text,
          noSTR: strController.text,
          tempatPraktik: praktikController.text,
          jamMulai: jamMulai!,
          jamSelesai: jamSelesai!,
          profile: profileController.text,
          pengalaman: int.parse(pengalamanController.text),
          pasien: 0,
          pendidikan: pendidikanControllers.map((e) => e.text).toList(),
          keahlian: keahlian.map((e) => e!).toList(),
        ),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result ?? "Daftar berhasil",
              style: GoogleFonts.inriaSerif(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 164, 183, 214),
          ),
        );
        setState(() {
          isLoading = false;
        });

        if (result == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FaIcon(
          FontAwesomeIcons.userDoctor,
          color: Color(0xFFD6A7C9),
          size: 55,
        ),
        const SizedBox(height: 8),
        Text(
          'Dokter',
          style: GoogleFonts.inriaSerif(
            fontSize: 18,
            color: const Color(0xFFD6A7C9),
          ),
        ),
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
                  text: currentState == 3 ? 'Daftar' : 'Next',
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
                      widget.onBack(() {
                        if (currentState == 0) {
                          Navigator.pop(context);
                        } else {
                          setState(() {
                            currentState--;
                          });
                        }
                      });
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
