import 'package:akusitumbuh/extensions/extension.dart';
import 'package:akusitumbuh/models/dokter_anak_model.dart';
import 'package:akusitumbuh/models/konsultansi_model.dart';
import 'package:akusitumbuh/models/orang_tua_model.dart';
import 'package:akusitumbuh/models/user_model.dart';
import 'package:akusitumbuh/screens/chat/chat_screen.dart';
import 'package:akusitumbuh/services/auth_service.dart';
import 'package:akusitumbuh/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardList extends StatefulWidget {
  final ChatModel chat;
  const CardList({super.key, required this.chat});

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  final AuthService _authService = AuthService();
  final ChatService _chatService = ChatService();

  DokterAnakModel? dokterProfile;
  OrangTuaModel? orangTuaProfile;
  UserModel? partnerAcc;
  bool loading = true;
  String? partnerId;
  String? userID;
  String? userLevel;
  @override
  void initState() {
    super.initState();
    _loadPartnerData();
  }

  Future<void> _loadPartnerData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getString('userId');
      userLevel = prefs.getString('userLevel');
    });
    final role = userLevel == 'Orang Tua' ? 'Dokter Anak' : 'Orang Tua';

    final chat = widget.chat;
    partnerId = chat.users.firstWhere((u) => u != userID);
    final data = await _authService.getProfileById(role, partnerId!);
    final acc = await _authService.getAccountByID(partnerId!);

    setState(() {
      partnerAcc = acc;
      if (userLevel == 'Orang Tua') {
        dokterProfile = data as DokterAnakModel;
      } else {
        orangTuaProfile = data as OrangTuaModel;
      }
      loading = false;
    });
  }

  String formatHari(DateTime date) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));
    final target = DateTime(date.year, date.month, date.day);

    if (target == today) return "Hari ini";
    if (target == yesterday) return "Kemarin";

    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final nama = userLevel == 'Orang Tua'
        ? dokterProfile?.fullname
        : orangTuaProfile?.childName;
    final chat = widget.chat;
    final unreadCount = chat.unread[userID] ?? 0;
    final ketWaktu = formatHari(chat.lastMessage.time);
    final time = ketWaktu == 'Hari ini'
        ? chat.lastMessage.time.toTime()
        : ketWaktu;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () async {
            final roomchatID = await _chatService.getChatRoom(partnerId!);
            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChatScreen(partnerID: partnerId!, roomChatID: roomchatID),
                ),
              );
            }
          },
          child: ListTile(
            leading: _buildPP(
              partnerAcc?.photo ?? 'assets/images/default-profile.png',
            ),
            title: Text(
              nama ?? '',
              style: GoogleFonts.poly(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (chat.lastMessage.idPengirim == userID)
                  _buildStatusIcon(chat.lastMessage.status),

                Text(
                  chat.lastMessage.text,
                  style: GoogleFonts.urbanist(color: Colors.grey),
                ),
              ],
            ),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (unreadCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF68C3BF),
                    ),
                    child: Text(
                      unreadCount.toString(),
                      style: GoogleFonts.poly(fontSize: 15),
                    ),
                  ),
                Text(time, style: GoogleFonts.urbanist(color: Colors.grey)),
              ],
            ),
          ),
        ),
        Divider(thickness: 2, color: Color(0xFFD9D9D9)),
      ],
    );
  }

  Widget _buildPP(String photo) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: (photo.toString().isNotEmpty)
              ? photo.toImageProvider()
              : AssetImage('assets/images/default-profile.png')
                    as ImageProvider,
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF68C3BF),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusIcon(int status) {
    switch (status) {
      case 0:
        return Icon(Icons.done, size: 20, color: Colors.grey);
      case 1:
        return Icon(Icons.done_all, size: 20, color: Colors.grey);
      default:
        return SizedBox();
    }
  }
}
