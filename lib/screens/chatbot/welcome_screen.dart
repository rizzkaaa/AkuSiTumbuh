
import 'package:akusitumbuh/screens/chatbot/chat_screen.dart';
import 'package:akusitumbuh/widgets/gradient_background2.dart';
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
      body: GradientBackground2(
        offset1: offset1,
        offset2: offset2,
        child: SafeArea(
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ChatScreen()),
            );
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
}
