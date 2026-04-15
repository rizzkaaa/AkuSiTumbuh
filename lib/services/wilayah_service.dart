import 'dart:convert';
import 'package:akusitumbuh/models/wilayah_model.dart';
import 'package:http/http.dart' as http;

class WilayahService {
  Future<List<WilayahModel>> fetchProvinsi() async {
    final res = await http.get(
      Uri.parse(
        'https://emsifa.github.io/api-wilayah-indonesia/api/provinces.json',
      ),
    );

    final data = json.decode(res.body) as List;
    return data.map((e) => WilayahModel.fromJson(e)).toList();
  }

  Future<List<WilayahModel>> fetchKabupaten(String provId) async {
    final res = await http.get(
      Uri.parse(
        'https://emsifa.github.io/api-wilayah-indonesia/api/regencies/$provId.json',
      ),
    );

    final data = json.decode(res.body) as List;
    return data.map((e) => WilayahModel.fromJson(e)).toList();
  }

  Future<List<WilayahModel>> fetchKecamatan(String kabId) async {
    final res = await http.get(
      Uri.parse(
        'https://emsifa.github.io/api-wilayah-indonesia/api/districts/$kabId.json',
      ),
    );

    final data = json.decode(res.body) as List;
    return data.map((e) => WilayahModel.fromJson(e)).toList();
  }
}
