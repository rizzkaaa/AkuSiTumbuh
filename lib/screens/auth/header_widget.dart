import 'package:akusitumbuh/screens/auth/wavy_banner.dart';
import 'package:akusitumbuh/widgets/header_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onBack;
  final bool isShow;

  const HeaderWidget({
    super.key,
     this.isShow = true,
    required this.title,
    required this.subtitle,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            _buildBg(),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 isShow ? Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(
                      onPressed: onBack ?? () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ) :
                  SizedBox(height: 25),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Transform.translate(
                          offset: Offset(0, -20),
                          child: HeaderText(label: title),
                        ),
                        Transform.translate(
                          offset: Offset(0, -40),
                          child: Text(
                            subtitle,
                            style: GoogleFonts.libreCaslonText(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBg() {
    return ClipPath(
      clipper: WavyBannerClipper(),
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFCCDDFB), Color(0xFFFFC9E6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
