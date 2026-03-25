import 'package:akusitumbuh/screens/chat/chat_screen.dart';
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

          Expanded(
            child: ListView(
              children: [
                _buildList(
                  photo: 'assets/images/1.png',
                  nama: 'dr. Alya Zilyanti',
                  msg: 'Iya tepat sekali',
                  status: 2,
                  jam: '20.30',
                  ur: 5,
                ),
                _buildList(
                  photo: 'assets/images/1.png',
                  nama: 'dr. Siti Khadijah Pramesti',
                  msg: 'Anda: Benar sekali',
                  status: 0,
                  jam: '20.28',
                ),
                _buildList(
                  photo: 'assets/images/1.png',
                  nama: 'dr. Rizky Pratama Wijaya',
                  msg: 'Terima kasih kembali',
                  status: 2,
                  jam: '19.00',
                ),
                _buildList(
                  photo: 'assets/images/1.png',
                  nama: 'dr. Dinda Maharani',
                  msg: 'Anda: baik dok',
                  status: 1,
                  jam: '16.05',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList({
    required String photo,
    required String nama,
    required String msg,
    required int status,
    int? ur,
    required String jam,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen()),
            );
          },
          child: ListTile(
            leading: _buildPP(photo),
            title: Text(nama, style: GoogleFonts.poly()),
            subtitle: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (status == 0) Icon(Icons.done, size: 20, color: Colors.grey),
                if (status == 1)
                  Icon(Icons.done_all, size: 20, color: Colors.grey),
                Text(msg, style: GoogleFonts.urbanist(color: Colors.grey)),
              ],
            ),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (ur != null)
                  Container(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      top: 5,
                      bottom: 8,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF68C3BF),
                    ),
                    child: Text(
                      ur.toString(),
                      style: GoogleFonts.poly(fontSize: 15),
                    ),
                  ),
                Text(jam, style: GoogleFonts.urbanist(color: Colors.grey)),
              ],
            ),
          ),
        ),
        Divider(thickness: 2, color: Color(0xFFD9D9D9)),
      ],
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
