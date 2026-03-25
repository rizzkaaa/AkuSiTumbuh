import 'package:akusitumbuh/screens/dokter/search_field.dart';
import 'package:akusitumbuh/widgets/custom_back_button.dart';
import 'package:akusitumbuh/widgets/gradient_background2.dart';
import 'package:akusitumbuh/widgets/header_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground2(
        content: SafeArea(
          child: Column(
            children: [
              CustomBackButton(),
              HeaderText(label: 'Message'),
              _buildHead(),
              Expanded(child: _buildMain()),
            ],
          ),
        ),
        offset1: [220, -171],
        offset2: [-140, 147],
      ),
    );
  }

  Widget _buildHead() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '5 Pesan',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Text(
            'Sedang Aktif',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                _buildPP('assets/images/default-profile.png'),
                const SizedBox(width: 20),
                _buildPP('assets/images/1.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMain() {
    return Container(
      // padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                SearchField(
                  controller: _searchController,
                  onChanged: (value) {},
                  onClear: () {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLabel('Semua', false),
                    _buildLabel('Belum Dibaca', true),
                    _buildLabel('Favorit', true),
                  ],
                ),
              ],
            ),
          ),

          Expanded(child: ListView(children: [
            ListTile(
              leading: _buildPP('assets/images/1.png'),
            )

          ],
        )),
        ],
      ),
    );
  }

  Widget _buildLabel(String label, bool isFully) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isFully ? Color(0xFFE3BCD1) : Color(0xFFFFEBF6),
        border: Border.all(color: Color(0xFFDC8DB7)),
      ),
      child: Text(
        label,
        style: GoogleFonts.urbanist(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  Widget _buildPP(String photo) {
    return Stack(
      children: [
        CircleAvatar(radius: 25, backgroundImage: AssetImage(photo)),
        Positioned(
          right: 0,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF68C3BF),
            ),
          ),
        ),
      ],
    );
  }
}
