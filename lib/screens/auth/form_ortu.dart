import 'package:akusitumbuh/models/orang_tua_model.dart';
import 'package:akusitumbuh/screens/auth/date_input.dart';
import 'package:akusitumbuh/screens/auth/input_form.dart';
import 'package:akusitumbuh/screens/auth/login_page.dart';
import 'package:akusitumbuh/services/auth_service.dart';
import 'package:akusitumbuh/widgets/gradient_button_3d.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormOrtu extends StatefulWidget {
  final String email;
  final String password;

  const FormOrtu({super.key, required this.email, required this.password});

  @override
  State<FormOrtu> createState() => _FormOrtuState();
}

class _FormOrtuState extends State<FormOrtu> {
  final AuthService _service = AuthService();
  final TextEditingController namaAnakController = TextEditingController();
  String? jenisKelamin;
  DateTime? tanggalLahir;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    namaAnakController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final email = widget.email;
      final password = widget.password;
      final childName = namaAnakController.text;

      final result = await _service.register(
        email: email,
        password: password,
        role: 'Orang Tua',
        orangTua: OrangTuaModel(
          childName: childName,
          jenisKelamin: jenisKelamin!,
          ttl: tanggalLahir!,
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
          Navigator.push(
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
          'Orang Tua',
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
                hint: "Nama anak",
                controller: namaAnakController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Masukkan nama anak";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                initialValue: jenisKelamin,
                hint: Text(
                  'Jenis kelamin anak',
                  style: GoogleFonts.inriaSerif(
                    color: const Color(0xFF9472C0).withValues(alpha: 0.5),
                    fontSize: 16,
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'L',
                    child: Text(
                      'Laki-laki',
                      style: GoogleFonts.inriaSerif(
                        fontSize: 16,
                        color: const Color(0xFF9472C0),
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'P',
                    child: Text(
                      'Perempuan',
                      style: GoogleFonts.inriaSerif(
                        fontSize: 16,
                        color: const Color(0xFF9472C0),
                      ),
                    ),
                  ),
                ],
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD6A7C9)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD6A7C9)),
                  ),
                ),
                validator: (value) {
                  if (value == null) return "Pilih jenis kelamin anak";
                  return null;
                },
                onChanged: (value) => setState(() => jenisKelamin = value),
              ),
              const SizedBox(height: 20),
              DateInput(
                hint: 'Tanggal lahir anak',
                onDateSelected: (date) {
                  setState(() => tanggalLahir = date);
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
