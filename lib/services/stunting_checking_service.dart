import 'dart:convert';
import 'package:akusitumbuh/models/data_stunting_model.dart';
import 'package:flutter/services.dart';

class StuntingCheckingService {
  static final StuntingCheckingService _instance =
      StuntingCheckingService._internal();

  factory StuntingCheckingService() {
    return _instance;
  }

  StuntingCheckingService._internal();
  List<DataStuntingModel> boys = [];
  List<DataStuntingModel> girls = [];

  Future<void> loadData() async {
    if (boys.isNotEmpty && girls.isNotEmpty) return;

    String boysJson = await rootBundle.loadString('assets/data/data-boys.json');
    String girlsJson = await rootBundle.loadString(
      'assets/data/data-girls.json',
    );

    List boysData = json.decode(boysJson);
    List girlsData = json.decode(girlsJson);

    boys = boysData.map((e) => DataStuntingModel.fromJson(e)).toList();
    girls = girlsData.map((e) => DataStuntingModel.fromJson(e)).toList();
  }

  DataStuntingModel getData(String gender, int month) {
    final list = gender == "boy" ? boys : girls;
    return list.firstWhere((e) => e.month == month);
  }
}
