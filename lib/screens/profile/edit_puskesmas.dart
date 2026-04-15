import 'package:akusitumbuh/models/domisili_model.dart';
import 'package:akusitumbuh/models/puskesmas_model.dart';
import 'package:akusitumbuh/screens/auth/input_form.dart';
import 'package:akusitumbuh/services/auth_service.dart';
import 'package:akusitumbuh/widgets/domisili_select.dart';
import 'package:akusitumbuh/widgets/gradient_button_3d.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPuskesmas extends StatefulWidget {
  final PuskesmasModel puskesmas;
  const EditPuskesmas({super.key, required this.puskesmas});

  @override
  State<EditPuskesmas> createState() => _EditPuskesmasState();
}

class _EditPuskesmasState extends State<EditPuskesmas> {
  final AuthService _service = AuthService();
  final TextEditingController namaPuskesController = TextEditingController();

  String? selectedProv;
  String? selectedKab;
  String? selectedKec;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final data = widget.puskesmas;
    namaPuskesController.text = data.puskesmasName;
  }

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
    final data = widget.puskesmas;

      final result = await _service.updateProfile(
        role: 'Puskesmas',
        puskesmas: PuskesmasModel(
          puskesmasName: namaPuskesController.text,
          domisili: DomisiliModel(
            prov: selectedProv ?? data.domisili.prov,
            kab: selectedKab ?? data.domisili.kab,
            kec: selectedKec ?? data.domisili.kec,
          ),
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
        // const Icon(Icons.family_restroom, color: Color(0xFFD6A7C9), size: 55),
        // const SizedBox(height: 8),
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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: GradientButton3d(
                  isLoading: isLoading,
                  text: 'Edit',
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
