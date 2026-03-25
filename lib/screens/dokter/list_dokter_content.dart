import 'package:akusitumbuh/models/dokter_anak_model.dart';
import 'package:akusitumbuh/screens/dokter/card_dokter.dart';
import 'package:akusitumbuh/screens/dokter/search_field.dart';
import 'package:akusitumbuh/services/auth_service.dart';
import 'package:akusitumbuh/widgets/header_text.dart';
import 'package:akusitumbuh/widgets/metal_text.dart';
import 'package:flutter/material.dart';

class ListDokterContent extends StatefulWidget {
  const ListDokterContent({super.key});

  @override
  State<ListDokterContent> createState() => _ListDokterContentState();
}

class _ListDokterContentState extends State<ListDokterContent> {
  final AuthService _service = AuthService();
  late Future<List<DokterAnakModel>> dokterData;
  final TextEditingController _searchController = TextEditingController();

  List<DokterAnakModel> _allDokter = [];
  List<DokterAnakModel> _filteredDokter = [];

  @override
  void initState() {
    super.initState();
    dokterData = _service.getAllDoctors().then((value) {
      _allDokter = value;
      _filteredDokter = value;
      return value;
    });
  }

  void _filterDokter(String keyword) {
    final query = keyword.toLowerCase();

    setState(() {
      _filteredDokter = _allDokter.where((dokter) {
        return dokter.fullname.toLowerCase().contains(query) ||
            dokter.tempatPraktik.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: HeaderText(label: 'Dokter Anak'),
            ),
            SearchField(
              controller: _searchController,
              onChanged: (value) => _filterDokter(value),
              onClear: () {
                _searchController.clear();
                _filterDokter('');
              },
            ),

            Expanded(
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: dokterData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFCEAABD),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: MetalText(text: 'Belum ada data'));
                    } else {
                      if (_allDokter.isEmpty) {
                        _allDokter = snapshot.data!;
                        _filteredDokter = snapshot.data!;
                      }

                      return Wrap(
                        children: List.generate(_filteredDokter.length, (i) {
                          return CardDokter(
                            key: ValueKey(_filteredDokter[i].docId),
                            dokter: _filteredDokter[i],
                            isPink: i % 2 == 0,
                          );
                        }),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
