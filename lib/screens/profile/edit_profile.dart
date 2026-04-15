import 'package:akusitumbuh/models/puskesmas_model.dart';
import 'package:akusitumbuh/models/dokter_anak_model.dart';
import 'package:akusitumbuh/models/orang_tua_model.dart';
import 'package:akusitumbuh/screens/profile/edit_dokter.dart';
import 'package:akusitumbuh/screens/profile/edit_ortu.dart';
import 'package:akusitumbuh/screens/profile/edit_puskesmas.dart';
import 'package:akusitumbuh/widgets/bg_create.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  final String role;
  final OrangTuaModel? orangTua;
  final DokterAnakModel? dokterAnak;
  final PuskesmasModel? puskesmas;
  const EditProfile({
    super.key,
    required this.role,
    this.orangTua,
    this.dokterAnak,
    this.puskesmas,
  });

  @override
  Widget build(BuildContext context) {
    return BgCreate(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
      colors: [
        const Color(0xFFB7C8E8).withValues(alpha: 0.25),
        const Color(0xFFD6A7C9).withValues(alpha: 0.25),
      ],
      child: role == 'Orang Tua'
          ? EditOrtu(orangTua: orangTua!)
          : role == 'Dokter Anak'
          ? EditDokter(dokterAnak: dokterAnak!)
          : EditPuskesmas(puskesmas: puskesmas!),
    );
  }
}
