import 'package:akusitumbuh/screens/chatbot/chat_widget.dart';
import 'package:akusitumbuh/screens/chatbot/header_text.dart';
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
              CustomBackButton(),
              HeaderText(),
              Transform.translate(
                offset: Offset(0, -8),
                child: Text(
                  'sahabat tumbuh',
                  style: GoogleFonts.metal(
                    color: Color(0xFFDC8DB7),
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(child: ChatWidget()),
            ],
          ),
        ),
      ),
    );
  }


}
