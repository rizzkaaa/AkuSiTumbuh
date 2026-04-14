import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class State3 extends StatefulWidget {
  final List<String?> keahlian;
  const State3({super.key, required this.keahlian});

  @override
  State<State3> createState() => _State3State();
}

class _State3State extends State<State3> {
  List<String> keahlianDokter = [
    "Tumbuh kembang anak",
    "Imunisasi",
    "Nutrisi anak",
    "MPASI",
    "Alergi anak",
    "Infeksi anak",
    "Konsultasi bayi baru lahir",
    "Keterlambatan perkembangan",
    "Gangguan makan anak",
    "Parenting kesehatan anak",
  ];

  @override
  Widget build(BuildContext context) {
    final keahlian = widget.keahlian;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Keahlian',
          style: GoogleFonts.inriaSerif(
            color: Color(0xFF9472C0).withValues(alpha: 0.5),
            fontSize: 16,
          ),
        ),

        Column(
          children: List.generate(keahlian.length, (index) {
            int size = keahlian.length - 1;
            bool isEnd = index == size;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: keahlian[index],
                      hint: Text(
                        "Pilih Keahlian",
                        style: GoogleFonts.inriaSerif(
                          color: Color(0xFFD6A7C9),
                          fontSize: 16,
                        ),
                      ),

                      icon: Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: Color(0xFFD6A7C9),
                      ),

                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 1),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFD6A7C9)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFD6A7C9)),
                        ),
                      ),

                      items: keahlianDokter
                          .where(
                            (e) =>
                                !keahlian.contains(e) || e == keahlian[index],
                          )
                          .map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Row(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.userDoctor,
                                    color: Color(0xFFD6A7C9),
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  SizedBox(
                                    width: 180,
                                    child: Text(
                                      e,
                                      style: GoogleFonts.inriaSerif(
                                        color: Color(0xFFD6A7C9),
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          keahlian[index] = value;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isEnd && size != 3
                          ? Icons.add_circle_outline
                          : Icons.remove_circle_outline,
                      color: Color(0xFFD6A7C9),
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        if (isEnd && size != 3) {
                          keahlian.add(null);
                        } else {
                          keahlian.removeAt(index);
                        }
                      });
                    },
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
