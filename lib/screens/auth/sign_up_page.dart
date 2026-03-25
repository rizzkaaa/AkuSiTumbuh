import 'package:akusitumbuh/widgets/bg_create.dart';
import 'package:akusitumbuh/screens/auth/form_profile.dart';
import 'package:akusitumbuh/screens/auth/role_step.dart';
import 'package:akusitumbuh/widgets/gradient_button_3d.dart';
import 'package:akusitumbuh/screens/auth/header_widget.dart';
import 'package:akusitumbuh/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int currentStep = 0;
  String? selectedRole;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (currentStep == 0) {
      if (_formKey.currentState!.validate()) {
        setState(() => currentStep = 1);
      }
    } else {
      if (selectedRole == 'Dokter Anak') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FormProfile(
              isDoctor: true,
              email: emailController.text,
              password: passwordController.text,
            ),
          ),
        );
      } else if (selectedRole == 'Orang Tua') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FormProfile(
              isDoctor: false,
              email: emailController.text,
              password: passwordController.text,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Pilih role dulu ya",
              style: GoogleFonts.inriaSerif(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 164, 183, 214),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HeaderWidget(
              title: 'Buat Akun',
              subtitle: 'Buat Akun untuk Melanjutkan',
              onBack: currentStep == 1
                  ? () => setState(() => currentStep = 0)
                  : () => Navigator.pop(context),
            ),
            const SizedBox(height: 80),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: BgCreate(
                child: currentStep == 0
                    ? _buildStepAkun()
                    : RoleStep(
                        selectedRole: selectedRole,
                        onChanged: (value) {
                          setState(() => selectedRole = value);
                        },
                      ),
              ),
            ),
            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: GradientButton3d(
                isLoading: false,
                text: 'Next',
                onPressed: _nextStep,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildStepAkun() {
    return Form(
      key: _formKey,
      child: Column(
          mainAxisSize: MainAxisSize.min,
        children: [
          CustomInput(
            hint: "Email",
            icon: Icons.email_outlined,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) return "Masukkan email";
              if (!value.contains("@") || !value.contains(".")) {
                return "Email tidak valid";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomInput(
            hint: 'Password',
            icon: Icons.lock_outline,
            controller: passwordController,
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) return "Masukkan password";
              if (value.length < 6) return "Minimal 6 karakter";
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomInput(
            hint: 'Confirm password',
            icon: Icons.lock_outline,
            controller: confirmPasswordController,
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Masukkan konfirmasi password";
              }
              if (value != passwordController.text) {
                return "Password tidak sama";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
