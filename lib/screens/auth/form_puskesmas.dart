import 'package:akusitumbuh/models/domisili_model.dart';
import 'package:akusitumbuh/models/puskesmas_model.dart';
import 'package:akusitumbuh/screens/auth/input_form.dart';
import 'package:akusitumbuh/screens/auth/login_page.dart';
import 'package:akusitumbuh/services/auth_service.dart';
import 'package:akusitumbuh/widgets/domisili_select.dart';
import 'package:akusitumbuh/widgets/gradient_button_3d.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormPuskesmas extends StatefulWidget {
  final String email;
  final String password;

  const FormPuskesmas({super.key, required this.email, required this.password});

  @override
  State<FormPuskesmas> createState() => _FormPuskesmasState();
}

class _FormPuskesmasState extends State<FormPuskesmas> {
  final AuthService _authService = AuthService();
  final TextEditingController namaPuskesController = TextEditingController();

  String? selectedProv;
  String? selectedKab;
  String? selectedKec;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    namaPuskesController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final email = widget.email;
      final password = widget.password;
      final namaPuskes = namaPuskesController.text;

      final result = await _authService.register(
        email: email,
        password: password,
        role: 'Puskesmas',
        puskesmas: PuskesmasModel(
          puskesmasName: namaPuskes,
          domisili: DomisiliModel(
            prov: selectedProv ?? '',
            kab: selectedKab ?? '',
            kec: selectedKec ?? '',
          ),
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
        const Icon(Icons.family_restroom, color: Color(0xFFD6A7C9), size: 55),
        const SizedBox(height: 8),
        Text(
          'Puskesmas',
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
              InputForm(
                hint: "Nama Puskesmas",
                controller: namaPuskesController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Masukkan nama puskesmas";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DomisiliSelect(
                isLoading: (value) {
                  setState(() {
                    isLoading = value;
                  });
                },
                selectedProv: (value) {
                  setState(() {
                    selectedProv = value;
                  });
                },
                selectedKab: (value) {
                  setState(() {
                    selectedKab = value;
                  });
                },
                selectedKec: (value) {
                  setState(() {
                    selectedKec = value;
                  });
                },
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: GradientButton3d(
                  isLoading: isLoading,
                  text: 'Simpan',
                  onPressed: _handleSubmit,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
