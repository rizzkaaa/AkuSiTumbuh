import 'package:akusitumbuh/models/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DokterAnakModel extends BaseModel {
  final String _fullname;
  final String _noSTR;
  final String _tempatPraktik;
  final TimeOfDay _jamMulai;
  final TimeOfDay _jamSelesai;
  final String _profile;
  final int _pengalaman;
  final int _pasien;
  final List<String> _pendidikan;
  final List<String> _keahlian;

  DokterAnakModel({
    super.docId,
    required String fullname,
    required String noSTR,
    required String tempatPraktik,
    required TimeOfDay jamMulai,
    required TimeOfDay jamSelesai,
    required String profile,
    required int pengalaman,
    required int pasien,
    required List<String> pendidikan,
    required List<String> keahlian,
    super.createdAt,
  }) : _fullname = fullname,
       _noSTR = noSTR,
       _tempatPraktik = tempatPraktik,
       _jamMulai = jamMulai,
       _jamSelesai = jamSelesai,
       _profile = profile,
       _pengalaman = pengalaman,
       _pasien = pasien,
       _pendidikan = pendidikan,
       _keahlian = keahlian;

  String get fullname => _fullname;
  String get noSTR => _noSTR;
  String get tempatPraktik => _tempatPraktik;
  TimeOfDay get jamMulai => _jamMulai;
  TimeOfDay get jamSelesai => _jamSelesai;
  String get profile => _profile;
  int get pengalaman => _pengalaman;
  int get pasien => _pasien;
  List<String> get pendidikan => _pendidikan;
  List<String> get keahlian => _keahlian;

  factory DokterAnakModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return DokterAnakModel(
      docId: doc.id,
      fullname: data['fullname'] ?? '-',
      noSTR: data['noSTR'] ?? '-',
      tempatPraktik: data['tempatPraktik'] ?? '-',

      jamMulai: TimeOfDay(
        hour: data['jamMulai']['hour']!,
        minute: data['jamMulai']['minute']!,
      ),

      jamSelesai: TimeOfDay(
        hour: data['jamSelesai']['hour']!,
        minute: data['jamSelesai']['minute']!,
      ),
      profile: data['profile'] ?? '',
      pengalaman: data['pengalaman'] ?? 0,
      pasien: data['pasien'] ?? 0,

      pendidikan: List<String>.from(data['pendidikan'] ?? []),
      keahlian: List<String>.from(data['keahlian'] ?? []),

      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'fullname': _fullname,
      'noSTR': _noSTR,
      'tempatPraktik': _tempatPraktik,
      'jamMulai': {"hour": _jamMulai.hour, "minute": _jamMulai.minute},
      'jamSelesai': {"hour": jamSelesai.hour, "minute": jamSelesai.minute},
      'profile': _profile,
      'pengalaman': _pengalaman,
      'pasien': _pasien,
      'pendidikan': _pendidikan,
      'keahlian': _keahlian,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
