import 'package:akusitumbuh/screens/chatbot/chat_widget.dart';
import 'package:akusitumbuh/screens/homepage.dart';
import 'package:flutter/cupertino.dart';
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
      body: _buildBg(
        content: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Homepage()),
                    ),
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),

              _buildHeader(),

              Expanded(
                child: ChatWidget()
              ),

              _buildTextField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Text(
              'Tumbi',
              style: GoogleFonts.lilitaOne(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 5
                  ..color = Color(0xFFDC8DB7),
              ),
            ),
            Text(
              'Tumbi',
              style: GoogleFonts.lilitaOne(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
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
      ],
    );
  }

  Widget _buildTextField() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [Color(0xFF92A7CD), Color(0xFFF4D6E6)],
                ),
              ),
              child: TextField(
                cursorColor: Color(0xFFB7C8E8),
                style: GoogleFonts.libreCaslonDisplay(
                  color: Color(0xFFB7C8E8),
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  hint: Text(
                    'Tanya apa saja',
                    style: GoogleFonts.libreCaslonDisplay(
                      color: Color(0xFFB7C8E8),
                      fontSize: 18,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF92A7CD), Color(0xFFF4D6E6)],
              ),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.paperplane,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
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
