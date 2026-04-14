import 'package:akusitumbuh/controller/chat_controller.dart';
import 'package:akusitumbuh/extensions/extension.dart';
import 'package:akusitumbuh/models/konsultansi_model.dart';
import 'package:akusitumbuh/services/chat_service.dart';
// import 'package:akusitumbuh/widgets/typing_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatWidget extends StatefulWidget {
  final String roomChatID;
  final String userID;
  final String partnerPhoto;
  const ChatWidget({
    super.key,
    required this.roomChatID,
    required this.userID,
    required this.partnerPhoto,
  });

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final ScrollController _scrollController = ScrollController();
  final ChatService _chatService = ChatService();
  late Stream<List<MessageModel>> messages;

  @override
  void initState() {
    super.initState();
    _chatService.resetUnread(widget.roomChatID);
    messages = _chatService.getMessages(widget.roomChatID);
  }

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

  final chat = ChatController();
  final controller = TextEditingController();

  String formatHari(DateTime date) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));
    final target = DateTime(date.year, date.month, date.day);

    if (target == today) return "Hari ini";
    if (target == yesterday) return "Kemarin";

    return "${date.day}/${date.month}/${date.year}";
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: StreamBuilder(
              stream: messages,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: Color(0xFFCEAABD)),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  final data = snapshot.data!;

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final msg = data[index];
                      final isPartner = msg.idPengirim != widget.userID;

                      final currentDate = msg.createdAt ?? DateTime.now();
                      bool showHeader = false;

                      if (index == 0) {
                        showHeader = true;
                      } else {
                        final prevDate =
                            data[index - 1].createdAt ?? currentDate;
                        if (!isSameDay(currentDate, prevDate)) {
                          showHeader = true;
                        }
                      }

                      return Column(
                        children: [
                          if (showHeader)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                formatHari(currentDate),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          Align(
                            alignment: !isPartner
                                ? Alignment.topRight
                                : Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: !isPartner
                                  ? _buildBubbleUser(msg)
                                  : _buildBubblePartner(msg),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),

        _buildTextField(controller, () async {
          await _chatService.addMessage(
            chatId: widget.roomChatID,
            message: MessageModel(
              idPengirim: widget.userID,
              text: controller.text,
              status: 0,
            ),
          );
          controller.clear();
          _scrollToBottom();
        }),
      ],
    );
  }

  Widget _buildBubblePartner(MessageModel msg) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPP(widget.partnerPhoto),
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SelectionArea(
                  child: MarkdownBody(
                    data: msg.text,
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

                SizedBox(width: 10),
                Text(
                  msg.createdAt!.toTime(),
                  style: GoogleFonts.urbanist(color: Colors.grey, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBubbleUser(MessageModel msg) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 230),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xFFDC8DB7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SelectableText(
              msg.text,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
            ),
            SizedBox(width: 10),
            Text(
              msg.createdAt.toTime(),
              style: GoogleFonts.urbanist(color: Colors.white, fontSize: 10),
            ),
            if (msg.status == 0)
              Icon(Icons.done, size: 15, color: Colors.white),
            if (msg.status == 1)
              Icon(Icons.done_all, size: 15, color: Colors.white),
          ],
        ),
      ),
    );
  }

  // Widget _buildTypingIndicator() {
  //   return Align(
  //     alignment: Alignment.centerLeft,
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         _buildPP('assets/images/1.png'),
  //         const SizedBox(width: 10),
  //         ConstrainedBox(
  //           constraints: BoxConstraints(maxWidth: 230),
  //           child: Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(20),
  //               border: Border.all(color: Color(0xFFDC8DB7)),
  //             ),
  //             child: TypingIndicator(color: Color(0xFFDC8DB7)),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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

  Widget _buildPP(String photo) {
    return CircleAvatar(
      radius: 25,
      backgroundImage: (photo.toString().isNotEmpty)
          ? photo.toImageProvider()
          : AssetImage('assets/images/default-profile.png') as ImageProvider,
    );
  }
}
