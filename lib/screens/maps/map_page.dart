import 'package:akusitumbuh/models/kabupaten_data_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akusitumbuh/widgets/legend_card.dart';
import 'package:akusitumbuh/screens/maps/geo_json_map.dart';


class MapsStuntingScreen extends StatefulWidget {
  const MapsStuntingScreen({super.key});

  @override
  State<MapsStuntingScreen> createState() => _MapsStuntingScreenState();
}

class _MapsStuntingScreenState extends State<MapsStuntingScreen> {
  KabupatenData? selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //  MAP
          Positioned.fill(
            child: GeoJsonMap(
              kabupatenList: kabupatenList,
              onTap: (data) {
                setState(() => selected = data);
              },
            ),
          ),

          /// TOP BAR
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Row(
              children: [
                _btn(Icons.arrow_back, () {
                  Navigator.pop(context);
                }),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      style: GoogleFonts.inriaSerif(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: "Cari lebih banyak",

                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFFD6A7C9),
                        ),

                        hintStyle: GoogleFonts.inriaSerif(
                          fontSize: 15,
                          color: const Color(0xFFD6A7C9),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Color(0xFFD6A7C9)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                            color: Color(0xFFD6A7C9), // pink kamu
                            width: 1.5,
                          ),
                        ),
                        // biar posisi teks pas tengah
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                _btn(Icons.tune, () {
                  print("tune diklik");
                }),
              ],
            ),
          ),

          /// POPUP
          if (selected != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 150,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Text(
                  selected!.name,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          Positioned(left: 16, bottom: 20, child: LegendCard()),
        ],
      ),
    );
  }

  Widget _btn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Color(0xFFD6A7C9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

