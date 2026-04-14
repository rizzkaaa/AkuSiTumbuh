import 'dart:convert';
import 'dart:math';
import 'package:akusitumbuh/models/data_stunting_model.dart';
// import 'package:akusitumbuh/models/dokter_anak_model.dart';
import 'package:akusitumbuh/models/history_model.dart';
import 'package:akusitumbuh/models/orang_tua_model.dart';
import 'package:akusitumbuh/services/auth_service.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StuntingCheckingService {
  final _auth = FirebaseAuth.instance;
  final _ref = FirebaseFirestore.instance;
  final AuthService _service = AuthService();
  // final birthDate = DateTime(2023, 3, 17);
  // final gender = 'boy';

  static final StuntingCheckingService _instance =
      StuntingCheckingService._internal();

  factory StuntingCheckingService() {
    return _instance;
  }

  StuntingCheckingService._internal();
  List<DataStuntingModel> lhfaBoys = [];
  List<DataStuntingModel> lhfaGirls = [];
  List<DataWeightModel> wfhBoys = [];
  List<DataWeightModel> wfhGirls = [];

  Future<void> loadData() async {
    if (lhfaBoys.isNotEmpty &&
        lhfaGirls.isNotEmpty &&
        wfhBoys.isNotEmpty &&
        wfhGirls.isNotEmpty) {
      return;
    }

    String lhfaBoysJson = await rootBundle.loadString(
      'assets/data/lhfa-boys.json',
    );
    String lhfaGirlsJson = await rootBundle.loadString(
      'assets/data/lhfa-girls.json',
    );
    String wfhBoysJson = await rootBundle.loadString(
      'assets/data/wfh-boys.json',
    );
    String wfhGirlsJson = await rootBundle.loadString(
      'assets/data/wfh-girls.json',
    );

    List lhfaBoysData = json.decode(lhfaBoysJson);
    List lhfaGirlsData = json.decode(lhfaGirlsJson);
    List wfhBoysData = json.decode(wfhBoysJson);
    List wfhGirlsData = json.decode(wfhGirlsJson);

    lhfaBoys = lhfaBoysData.map((e) => DataStuntingModel.fromJson(e)).toList();
    lhfaGirls = lhfaGirlsData
        .map((e) => DataStuntingModel.fromJson(e))
        .toList();
    wfhBoys = wfhBoysData.map((e) => DataWeightModel.fromJson(e)).toList();
    wfhGirls = wfhGirlsData.map((e) => DataWeightModel.fromJson(e)).toList();
  }

  DataStuntingModel getDataStunting(String gender, int month) {
    final list = gender == "L" ? lhfaBoys : lhfaGirls;
    return list.firstWhere((e) => e.month == month);
  }

  DataWeightModel getDataWeight(String gender, double height) {
    final list = gender == "L" ? wfhBoys : wfhGirls;
    return list.firstWhere((e) => e.height == height);
  }

  int ageInMonths(DateTime birthDate) {
    DateTime now = DateTime.now();

    int months =
        (now.year - birthDate.year) * 12 + (now.month - birthDate.month);

    if (now.day < birthDate.day) {
      months--;
    }

    return months;
  }

  double calculateZScoreStunting(double height, int L, double M, double S) {
    return (pow((height / M), L) - 1) / (L * S);
  }

  double calculateZScoreWeight(double weight, double L, double M, double S) {
    return (pow(weight / M, L) - 1) / (L * S);
  }

  Future<int> checkStunting(double tb, double bb) async {
    final OrangTuaModel orangTua =
        await _service.getProfile('Orang Tua') as OrangTuaModel;

    final month = ageInMonths(orangTua.ttl);
    if (month < 24 || month > 60) {
      return -1;
    }
    var data = getDataStunting(orangTua.jenisKelamin, month);

    final X = tb;
    final L = data.L;
    final M = data.M;
    final S = data.S;

    final Z = calculateZScoreStunting(X, L, M, S);

    int stuntingResult = -1;
    String status = '';

    if (Z >= -2) {
      stuntingResult = 0;
      status = 'Normal';
    } else if (Z >= -3) {
      stuntingResult = 1;
      status = 'Terdeteksi Stunting';
    } else {
      stuntingResult = 2;
      status = 'Stunting Berat';
    }

    await insertHistory(tb, bb, status);
    return stuntingResult;
  }

  Future<int> checkWeight(double tb, double bb) async {
    final OrangTuaModel orangTua =
        await _service.getProfile('Orang Tua') as OrangTuaModel;

    var data = getDataWeight(orangTua.jenisKelamin, tb);

    final X = bb;
    final L = data.L;
    final M = data.M;
    final S = data.S;

    final Z = calculateZScoreWeight(X, L, M, S);

    int weightResult = -1;

    if (Z > 2) {
      weightResult = 2;
    } else if (Z < -2) {
      weightResult = 1;
    } else {
      weightResult = 0;
    }

    return weightResult;
  }

  Future<List<HistoryModel>> getAllHistory() async {
    final uid = _auth.currentUser!.uid;

    final snapshot = await _ref
        .collection('history')
        .where('userID', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs.map((doc) => HistoryModel.fromFirestore(doc)).toList();
  }

  Future<void> insertHistory(double tb, double bb, String status) async {
    final uid = _auth.currentUser!.uid;
    final OrangTuaModel orangTua =
        await _service.getProfile('Orang Tua') as OrangTuaModel;

    final month = ageInMonths(orangTua.ttl);

    await _ref
        .collection('history')
        .add(
          HistoryModel(
            userID: uid,
            usia: month.toString(),
            tb: tb,
            bb: bb,
            status: status,
          ).toFirestore(),
        );
  }
}
