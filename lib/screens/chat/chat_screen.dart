import 'package:akusitumbuh/screens/chat/chat_widget.dart';
import 'package:akusitumbuh/widgets/custom_back_button.dart';
import 'package:akusitumbuh/widgets/gradient_backgtound3.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackgtound3(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(child: ChatWidget()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFCCDDFB),
        border: Border(
          bottom: BorderSide(color: Colors.black.withValues(alpha: 0.25)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            offset: Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'dr. Alya Zilyanti, Sp.A',
                style: GoogleFonts.poly(color: Color(0xFF996781), fontSize: 20),
              ),
              Text(
                'online',
                style: GoogleFonts.metal(
                  color: Color(0xFFDC8DB7),
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
          CustomBackButton(),
        ],
      ),
    );
  }


}
