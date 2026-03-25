import 'package:akusitumbuh/screens/chatbot/chat_widget.dart';
import 'package:akusitumbuh/screens/chatbot/header_text.dart';
import 'package:akusitumbuh/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBg(
        content: SafeArea(
          child: Column(
            children: [
              CustomBackButton(),
              HeaderText(),

              Expanded(child: ChatWidget()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBg({required Widget content}) {
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

        content,
      ],
    );
  }

}
