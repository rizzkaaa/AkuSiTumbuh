import 'package:akusitumbuh/models/wilayah_model.dart';
import 'package:akusitumbuh/services/wilayah_service.dart';
import 'package:akusitumbuh/widgets/dropdown.dart';
import 'package:flutter/material.dart';

class DomisiliSelect extends StatefulWidget {
  final Function(String?) selectedProv;
  final Function(String?) selectedKab;
  final Function(String?) selectedKec;
  final Function(bool) isLoading;

  const DomisiliSelect({
    super.key,
    required this.selectedProv,
    required this.selectedKab,
    required this.selectedKec,
    required this.isLoading,
  });

  @override
  State<DomisiliSelect> createState() => _DomisiliSelectState();
}

class _DomisiliSelectState extends State<DomisiliSelect> {
  final WilayahService _wilayahService = WilayahService();

  List<WilayahModel> provinsi = [];
  List<WilayahModel> kabupaten = [];
  List<WilayahModel> kecamatan = [];

  String? selectedProv;
  String? selectedKab;
  String? selectedKec;

  @override
  void initState() {
    super.initState();
    loadProvinsi();
  }

  void loadProvinsi() async {
    provinsi = await _wilayahService.fetchProvinsi();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Dropdown(
          label: "Pilih Provinsi",
          selectedValue: selectedProv,
          items: provinsi.map((e) => e.name).toList(),
          onChanged: (value) async {
            selectedProv = value;
            widget.selectedProv(value);
            final selected = provinsi.firstWhere((e) => e.name == value);
            widget.isLoading(true);
            kabupaten = await _wilayahService.fetchKabupaten(selected.id);
            selectedKab = null;
            selectedKec = null;
            kecamatan = [];
            widget.isLoading(false);

            setState(() {});
          },
        ),
        const SizedBox(height: 20),

        Dropdown(
          label: "Pilih Kabupaten",
          selectedValue: selectedKab,
          items: kabupaten.map((e) => e.name).toList(),
          onChanged: (value) async {
            selectedKab = value;
            widget.selectedKab(value);

            final selected = kabupaten.firstWhere((e) => e.name == value);
            widget.isLoading(true);

            kecamatan = await _wilayahService.fetchKecamatan(selected.id);
            selectedKec = null;
            widget.isLoading(false);

            setState(() {});
          },
        ),

        const SizedBox(height: 20),

        Dropdown(
          label: "Pilih Kecamatan",
          selectedValue: selectedKec,
          items: kecamatan.map((e) => e.name).toList(),
          onChanged: (value) {
            selectedKec = value;
            widget.selectedKab(value);

            setState(() {});
          },
        ),
      ],
    );
  }
}
