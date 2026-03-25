import 'package:akusitumbuh/controller/chat_controller.dart';
import 'package:akusitumbuh/widgets/typing_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatWidget extends StatelessWidget {
  final bool floating;
  ChatWidget({super.key, this.floating = false});
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuart,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chat = ChatController();
    final controller = TextEditingController();

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: AnimatedBuilder(
              animation: chat,
              builder: (context, _) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: chat.messages.length,
                        itemBuilder: (context, index) {
                          final msg = chat.messages[index];
                          final isUser = msg['role'] == 'user';

                          return Align(
                            alignment: isUser
                                ? Alignment.topRight
                                : Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: isUser
                                  ? _buildBubbleUser(msg['content']!)
                                  : _buildBubbleBot(msg['content']!),
                            ),
                          );
                        },
                      ),
                    ),

                    if (chat.isLoading) _buildTypingIndicator(),
                  ],
                );
              },
            ),
          ),
        ),

        _buildTextField(controller, () {
          chat.sendMessage(controller.text);
          controller.clear();
          _scrollToBottom();
        }),
      ],
    );
  }

  Widget _buildBubbleBot(String msg) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/icon_bot2.png', width: 30),
        const SizedBox(width: 10),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: floating ? 200 : 230),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(0xFFDC8DB7)),
            ),
            child: SelectionArea(
              child: MarkdownBody(
                data: msg,
                styleSheet: MarkdownStyleSheet(
                  p: GoogleFonts.poppins(
                    color: Color(0xFFDC8DB7),
                    fontSize: 12,
                  ),
                  strong: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFDC8DB7),
                  ),
                  listBullet: GoogleFonts.poppins(color: Color(0xFFDC8DB7)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBubbleUser(String msg) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: floating ? 200 : 230),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xFFDC8DB7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: SelectableText(
          msg,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/icon_bot2.png', width: 30),
          const SizedBox(width: 10),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 230),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFFDC8DB7)),
              ),
              child: TypingIndicator(color: Color(0xFFDC8DB7)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    VoidCallback onPressed,
  ) {
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
                controller: controller,
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
              onPressed: onPressed,
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
}
