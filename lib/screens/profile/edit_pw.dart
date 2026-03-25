import 'package:akusitumbuh/services/auth_service.dart';
import 'package:akusitumbuh/widgets/bg_create.dart';
import 'package:akusitumbuh/widgets/custom_input.dart';
import 'package:akusitumbuh/widgets/gradient_button_3d.dart';
import 'package:akusitumbuh/widgets/header_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPw extends StatefulWidget {
  const EditPw({super.key});

  @override
  State<EditPw> createState() => _EditPwState();
}

class _EditPwState extends State<EditPw> {
  final AuthService _service = AuthService();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  void handleSubmit() async {
    if (newPasswordController.text.trim().isNotEmpty &&
        oldPasswordController.text.trim().isNotEmpty) {
      if (isLoading) return;
      setState(() {
        isLoading = true;
      });

      final result = await _service.updatePassword(
        oldPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
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
        if (result == null) {
          Navigator.pop(context);
        }

        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HeaderText(label: 'Edit Password'),
            BgCreate(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomInput(
                    hint: 'Password Lama',
                    icon: Icons.lock_outline,
                    controller: oldPasswordController,
                    isPassword: true,
                    validator: (value) {
                      if (newPasswordController.text.isNotEmpty &&
                          (value == null || value.isEmpty)) {
                        return "Enter your old password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomInput(
                    hint: 'Password Baru',
                    icon: Icons.lock_outline,
                    controller: newPasswordController,
                    isPassword: true,
                    validator: (value) {
                      if (value != null &&
                          value.isNotEmpty &&
                          value.length < 6) {
                        return "Enter minimal 6 character";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 100,
                vertical: 20,
              ),
              child: GradientButton3d(
                isLoading: isLoading,
                text: 'Edit',
                onPressed: handleSubmit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
