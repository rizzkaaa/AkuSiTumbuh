import 'package:akusitumbuh/screens/chatbot/chat_screen.dart';
import 'package:akusitumbuh/screens/chatbot/chat_widget.dart';
import 'package:akusitumbuh/screens/chatbot/header_text.dart';
import 'package:akusitumbuh/widgets/gradient_backgtound3.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart' as inset;
import 'package:flutter/material.dart';

class ChatFloating extends StatefulWidget {
  const ChatFloating({super.key});

  @override
  State<ChatFloating> createState() => _ChatFloatingState();
}

class _ChatFloatingState extends State<ChatFloating> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: inset.BoxDecoration(
            boxShadow: [
              inset.BoxShadow(
                color: Color(0xFF000000).withValues(alpha: 0.25),
                offset: Offset(4, -4),
                blurRadius: 4,
                inset: true,
              ),
            ],
            color: Color(0xFFF4D6E6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: Colors.transparent,
            onPressed: () => setState(() => isOpen = true),
            child: Image.asset('assets/images/icon_bot.png', width: 40),
          ),
        ),

        if (isOpen)
          Positioned(
            child: Material(
              elevation: 12,
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: 300,
                height: 450,
                child: GradientBackgtound3(
                  child: Column(
                    children: [
                      Row( 
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: HeaderText(),
                          ),
                          Row(
                            children: [
                              
                              _buildIcon('Layar penuh', Icons.fullscreen, () =>  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const ChatScreen(),
                                    ),
                                  )),
                              _buildIcon('Tutup', Icons.close, () => setState(() => isOpen = false))
                            ],
                          ),
                        ],
                      ),

                      const Divider(thickness: 1.5, color: Colors.white),
                    
                        Expanded(child: ChatWidget(floating: true,)),
                    
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildIcon( String tooltip, IconData icon, VoidCallback onPressed) {
    return IconButton(
      tooltip: "tutup",
      icon: Icon(icon, color: Colors.white,),
      onPressed: onPressed,
    );
  }


}
