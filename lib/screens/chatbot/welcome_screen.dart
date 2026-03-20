import 'dart:ui';

import 'package:akusitumbuh/screens/chatbot/chat_screen.dart';
import 'package:akusitumbuh/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isNext = false;
  List<double> offset1 = [240, -82];
  List<double> offset2 = [-192, 243];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBg(
        offset1: offset1,
        offset2: offset2,
        content: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              isNext ? _nextSession() : _welcomeSession(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _welcomeSession() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        _buildMainContent(
          title: 'Halo, Sahabat!\nAku Tumbi',
          subtitle:
              'siap menemani dan membantu kamu memahami tumbuh kembang anak.',
          label: 'Next',
          onTap: () => setState(() {
            isNext = true;
            offset1 = [-125, -82];
            offset2 = [239, 243];
          }),
        ),
        _buildImg('assets/images/robot1.png'),
      ],
    );
  }

  Widget _nextSession() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        _buildMainContent(
          title: 'Yuk, \nmulai percakapan!',
          subtitle:
              'Tanyakan apa saja seputar pertumbuhan, gizi, dan kesehatan anak.',
          label: 'Mulai',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen(),));
          },
        ),
        _buildImg('assets/images/robot2.png'),
      ],
    );
  }

  Widget _buildImg(String path) {
    return Positioned(top: -270, child: Image.asset(path, width: 298));
  }

  Widget _buildMainContent({
    required String title,
    required String subtitle,
    required String label,
    required GestureTapCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.libreBodoni(
              color: Color(0xFF996781),
              fontSize: 25,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(subtitle, style: GoogleFonts.libreCaslonDisplay(fontSize: 20)),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: GradientButton(label: label, onTap: onTap),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBg({
    required Widget content,
    required List<double> offset1,
    required List<double> offset2,
  }) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFCCDDFB),
                Color(0xFFE4E9FD),
                Color(0xFFFBDDED),
                Colors.white,
              ],
              stops: [0.0, 0.3, 0.5, 1.0],
            ),
          ),
        ),

        _buildBlurLayer(offset1, 250, Color(0xFF92A6CD)),
        _buildBlurLayer(offset2, 270, Color(0xFFD6A7C9)),
        content,
      ],
    );
  }

  Widget _buildBlurLayer(List<double> offset, double size, Color color) {
    return AnimatedPositioned(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      left: offset[0],
      top: offset[1],
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.8),
                  blurRadius: 50,
                  spreadRadius: 10,
                ),
                BoxShadow(
                  color: color.withValues(alpha: 0.5),
                  blurRadius: 20,
                  spreadRadius: 30,
                ),
              ],
              shape: BoxShape.circle,

              color: color,
            ),
          ),

          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ],
      ),
    );
  }
}
