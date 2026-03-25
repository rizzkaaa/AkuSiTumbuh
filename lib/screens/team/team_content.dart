import 'package:akusitumbuh/widgets/header_text.dart';
import 'package:akusitumbuh/widgets/metal_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamContent extends StatelessWidget {
  TeamContent({super.key});

  final List<Map<String, dynamic>> tim = [
    {
      'nama': 'Rizka Layla Ramadhani',
      'sosmed': [
        {
          'email': 'rizkalaylaramadhani@gmail.com',
          'wa': '0857-6692-7491',
          'ig': 'rzkaaramadhani',
          'roblox': 'munbaebae',
        },
      ],
    },
    {
      'nama': 'Alya Zilyanti',
      'sosmed': [
        {
          'email': 'alyazilyanti3@gmail.com',
          'wa': '0836-3710-4022',
          'ig': 'zlynyaa',
          'roblox': '07_Lyaya',
        },
      ],
    },
    {
      'nama': 'Sella Allisya Salsabila',
      'sosmed': [
        {
          'email': 'sellaallisyasalsabila@gmail.com',
          'wa': '0831-7580-3222',
          'ig': '5el_iensie',
          'roblox': 'selaikeju',
        },
      ],
    },
  ];

  FaIconData getIcon(String key) {
    switch (key) {
      case 'email':
        return FontAwesomeIcons.envelope;
      case 'wa':
        return FontAwesomeIcons.whatsapp;
      case 'ig':
        return FontAwesomeIcons.instagram;
      case 'roblox':
        return FontAwesomeIcons.cube;
      default:
        return FontAwesomeIcons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: HeaderText(label: 'Tim Kami'),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildBox(
                  label: 'Temui Tim Kami:',
                  value:
                      'Kami adalah tim yang berkomitmen mengembangkan aplikasi untuk membantu orang tua memantau tumbuh kembang anak secara mudah dan informatif.',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: _buildMainContent(),
                ),

                _buildDosen(),
                _buildBox(
                  label: 'Motivasi Kami:',
                  value:
                      'Aplikasi ini dibuat sebagai bentuk kepedulian terhadap tumbuh kembang anak, khususnya dalam mencegah risiko stunting sejak dini. Kami berharap aplikasi ini dapat membantu orang tua dalam memantau pertumbuhan anak dengan lebih mudah, cepat, dan akurat.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBox({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.merienda(color: Color(0xFF996781), fontSize: 14),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(color: Color(0xFFD6A7C9)),
            ),
            child: MetalText(text: value),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        SizedBox(width: 220, child: _buildCardTeam(tim[0], 1)),
        const SizedBox(height: 25),
        Row(
          children: tim.asMap().entries.skip(1).map((entry) {
            final index = entry.key;
            final e = entry.value;

            return Expanded(child: _buildCardTeam(e, index + 1));
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCardTeam(Map<String, dynamic> tim, int i) {
    final sosmed = tim['sosmed'][0];
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFF4D6E6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Text(
                tim['nama'],
                style: GoogleFonts.libreBodoni(color: Color(0xFF996781)),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    ...sosmed.entries.map((entry) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              FaIcon(
                                getIcon(entry.key),
                                color: Color(0xFF996781),
                                size: 12,
                              ),
                              const SizedBox(width: 10),
                              SelectableText(
                                '${entry.value}',
                                style: GoogleFonts.poppins(fontSize: 6),
                              ),
                            ],
                          ),
                          Divider(thickness: 1, color: Color(0xFF996781)),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: -30,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFFF4D6E6), width: 10),
            ),
            child: CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage('assets/images/av$i.jpeg'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDosen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dosen Pembimbing:',
            style: GoogleFonts.merienda(color: Color(0xFF996781), fontSize: 14),
          ),
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Row(
                children: [
                  const SizedBox(width: 80),
                  Expanded(child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [Color(0xFF94A8CE), Color(0xFFF4D6E7)],
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Muhammad Setya Pratama, S.E., M.Si.',
                        style: GoogleFonts.libreBodoni(
                          color: Color(0xFF996781),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ))
                  ,
                ],
              ),

              Container(
                width: 100,
                height: 100,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFE4E9FD),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset('assets/images/pak_setya.png'),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
