import 'package:akusitumbuh/models/dokter_anak_model.dart';
import 'package:akusitumbuh/models/orang_tua_model.dart';
import 'package:akusitumbuh/models/user_model.dart';
import 'package:akusitumbuh/screens/chat/chat_list_screen.dart';
import 'package:akusitumbuh/screens/chat/chat_widget.dart';
import 'package:akusitumbuh/services/auth_service.dart';
import 'package:akusitumbuh/widgets/custom_back_button.dart';
import 'package:akusitumbuh/widgets/gradient_backgtound3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  final String roomChatID;
  final String partnerID;
  const ChatScreen({
    super.key,
    required this.partnerID,
    required this.roomChatID,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final AuthService _authService = AuthService();
  DokterAnakModel? dokterProfile;
  OrangTuaModel? orangTuaProfile;
  UserModel? partnerAcc;
  bool loading = true;

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

    final data = await _authService.getProfileById(role, widget.partnerID);
    final acc = await _authService.getAccountByID(widget.partnerID);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackgtound3(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),

              Expanded(
                child: userID == null || partnerAcc == null
                    ? Center(child: CircularProgressIndicator())
                    : ChatWidget(
                        roomChatID: widget.roomChatID,
                        userID: userID!,
                        partnerPhoto: partnerAcc!.photo,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final name = userLevel == 'Orang Tua'
        ? dokterProfile?.fullname
        : orangTuaProfile?.childName;

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
          loading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      name ?? '',
                      style: GoogleFonts.poly(
                        color: Color(0xFF996781),
                        fontSize: 20,
                      ),
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
          CustomBackButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ChatListScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
