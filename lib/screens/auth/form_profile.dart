import 'package:akusitumbuh/widgets/bg_create.dart';
import 'package:akusitumbuh/screens/auth/form_dokter.dart';
import 'package:akusitumbuh/screens/auth/form_ortu.dart';
import 'package:akusitumbuh/screens/auth/header_widget.dart';
import 'package:flutter/material.dart';

class FormProfile extends StatefulWidget {
  final bool isDoctor;
  final String email;
  final String password;

  const FormProfile({
    super.key,
    required this.email,
    required this.password,
    required this.isDoctor,
  });

  @override
  State<FormProfile> createState() => _FormProfileState();
}

class _FormProfileState extends State<FormProfile> {
  late VoidCallback onBack;

  @override
  void initState() {
    super.initState();
    onBack = () {
      Navigator.pop(context);
    };
  }

  @override
  Widget build(BuildContext context) {
    final email = widget.email;
    final password = widget.password;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeaderWidget(
                title: 'Buat Akun',
                subtitle: 'Buat Akun untuk Melanjutkan',
                onBack: onBack,
              ),
              const SizedBox(height: 50),
              BgCreate(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
                colors: [
                  const Color(0xFFB7C8E8).withValues(alpha: 0.25),
                  const Color(0xFFD6A7C9).withValues(alpha: 0.25),
                ],
                child: widget.isDoctor
                    ? FormDokter(
                        email: email,
                        password: password,
                        onBack: (callback) {
                          setState(() {
                            onBack = callback;
                          });
                        },
                      )
                    : FormOrtu(email: email, password: password),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
