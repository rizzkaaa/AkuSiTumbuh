import 'package:akusitumbuh/widgets/custom_input.dart';
import 'package:akusitumbuh/screens/auth/sign_up_page.dart';
import 'package:akusitumbuh/widgets/bg_create.dart';
import 'package:akusitumbuh/screens/homepage.dart';
import 'package:akusitumbuh/services/auth_service.dart';
import 'package:akusitumbuh/widgets/gradient_button_3d.dart';
import 'package:akusitumbuh/screens/auth/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _service = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordHidden = true;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handleSubmit() async {
    if(isLoading) return;
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final email = emailController.text;
      final password = passwordController.text;
      final result = await _service.login(email, password);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result ?? "Login berhasil",
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
            MaterialPageRoute(builder: (context) => const Homepage()),
          );
        }
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
              isShow: false,
              title: 'Masuk Akun',
              subtitle: 'Selamat Datang Kembali !',
            ),
            const SizedBox(height: 80),
            _buildForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BgCreate(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomInput(
                    hint: "Masukkan email",
                    icon: Icons.email_outlined,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukkan email";
                      }
                      if (!value.contains("@") || !value.contains(".")) {
                        return "Email tidak valid";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomInput(
                    hint: 'Masukkan password',
                    icon: Icons.lock_outline,
                    controller: passwordController,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukkan password";
                      }
                      if (value.length < 6) {
                        return "Minimal 6 karakter";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: GradientButton3d(
                isLoading: isLoading,
                text: "Login",
                onPressed: handleSubmit,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: GoogleFonts.libreFranklin(
                    color: const Color(0xFFB7C8E8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 3),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.libreFranklin(
                      color: const Color(0xFF849AC3),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
