import 'package:akusitumbuh/screens/home/home_photo.dart';
import 'package:akusitumbuh/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildLogo(), _buildContent(context)],
    );
  }

  Widget _buildLogo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "AkuSiTumbuh",
          style: GoogleFonts.lobsterTwo(
            fontSize: 30,
            foreground: Paint()
              ..shader = LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF7B8DB1), Color(0xFFB871A5)],
              ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
          ),
        ),
        Container(
          width: 200,
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF7B8DB1), Color(0xFFB871A5)],
            ),
          ),
        ),
        Text(
          'Temani Tumbuh Kembang Anak',
          style: GoogleFonts.metal(color: Color(0xFF5B5A5A)),
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, GestureTapCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [Color(0xFFB7C8E8), Color(0xFFF5B6D7)],
        ).createShader(bounds),
        child: Icon(icon, size: 40, color: Color(0xFFE4E9FD)),
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(),)),
      child: Container(
        padding: EdgeInsets.only(left: 3, top: 1, bottom: 1),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFB7C8E8), Color(0xFFF5B6D7)],
          ),
        ),

        child: HomePhoto()
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFB7C8E8), Color(0xFFF5B6D7)],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            _buildIconButton(Icons.chat, () {}),
            _buildIconButton(Icons.pin_drop_outlined, () {}),
            _buildProfileImage(context),
          ],
        ),
      ),
    );
  }
}
