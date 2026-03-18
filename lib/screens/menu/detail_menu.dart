import 'package:akusitumbuh/models/menu_model.dart';
import 'package:akusitumbuh/widgets/metal_text.dart';
import 'package:akusitumbuh/widgets/unordered_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailMenu extends StatelessWidget {
  final MenuModel item;
  final bool pink;
  const DetailMenu({super.key, required this.item, required this.pink});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBackground(
        SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: pink ? Color(0xFF996781) : Color(0xFF677899),
                      size: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 250,
                child: Text(
                  item.title,
                  style: GoogleFonts.libreBodoni(
                    color: pink ? Color(0xFF996781) : Color(0xFF677899),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 70),
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(50),
                        ),
                        border: Border(
                          top: BorderSide(
                            color: pink ? Color(0xFFD6A7C9) : Color(0xFF92A6CD),
                            width: 5,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.only(top: 50),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: ListView(
                          children: [
                            _buildExplanation('Bahan Utama', item.bahanUtama),
                            if (item.bumbudanBahanTambahan.isNotEmpty)
                              _buildExplanation(
                                'Bumbu dan Bahan Tambahan',
                                item.bumbudanBahanTambahan,
                              ),
                            _buildHowToCook(),
                            _buildExplanation('Manfaat Gizi', item.manfaatGizi),
                          ],
                        ),
                      ),
                    ),
                    _buildImgLabel(item.image),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackground(Widget content) {
    return Stack(
      children: [
        Container(
          height: 400,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                pink ? Color(0xFFF4D6E6) : Color(0xFFD6E1F4),
                Colors.white,
              ],
            ),
          ),
        ),
        content,
      ],
    );
  }

  Widget _buildImgLabel(String image) {
    return Positioned(
      top: -60,
      left: -20,
      child: Image.asset(
        'assets/images/menu/$image',
        width: 200,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildBoxExplanation({
    required String label,
    required Widget content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.kumarOne(
              color: pink ? Color(0xFF996781) : Color(0xFF677899),
              fontSize: 12,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildExplanation(String label, List<String> items) {
    return _buildBoxExplanation(
      label: label,
      content: Column(
        children: items.map((item) => UnorderedList(text: item)).toList(),
      ),
    );
  }

  Widget _buildHowToCook() {
    return _buildBoxExplanation(
      label: "Cara Memasak",
      content: Column(
        children: item.caraMasak.asMap().entries.map((entry) {
          final index = entry.key;
          final value = entry.value;

          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MetalText(text: '${index + 1}. ${' '}'),
                  Expanded(child: MetalText(text: value.label)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: value.langkah
                      .map((item) => UnorderedList(text: item))
                      .toList(),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
