import 'package:akusitumbuh/screens/auth/login_page.dart';
import 'package:akusitumbuh/screens/profile/dokter_screen.dart';
import 'package:akusitumbuh/screens/profile/orang_tua_screen.dart';
import 'package:akusitumbuh/services/auth_service.dart';
import 'package:akusitumbuh/widgets/custom_back_button.dart';
import 'package:akusitumbuh/widgets/gradient_background2.dart';
import 'package:akusitumbuh/widgets/header_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userID;
  String? userLevel;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getString('userId');
      userLevel = prefs.getString('userLevel');
    });
  }

  final AuthService _service = AuthService();
  final String role = 'Orang Tua';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground2(
        content: SafeArea(
          child: userID == null
              ? Center(child: CircularProgressIndicator(color: Colors.white))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: HeaderText(label: 'Profile'),
                    ),
                    const SizedBox(height: 70),

                    Expanded(
                      child: userLevel! == "Orang Tua"
                          ? OrangTuaScreen(
                              userID: userID!,
                              userLevel: userLevel!,
                            )
                          : DokterScreen(
                              userID: userID!,
                              userLevel: userLevel!,
                            ),
                    ),
                  ],
                ),
        ),
        offset1: [277, -91],
        offset2: [-118, 150],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomBackButton(),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () async {
              await _service.logout();
              if (context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              }
            },
            icon: Icon(Icons.meeting_room, color: Colors.white, size: 30),
          ),
        ),
      ],
    );
  }
}
