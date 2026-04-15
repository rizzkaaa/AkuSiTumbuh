import 'package:akusitumbuh/screens/chatbot/chat_floating.dart';
import 'package:akusitumbuh/screens/dokter/list_dokter_content.dart';
import 'package:akusitumbuh/screens/history/history_content.dart';
import 'package:akusitumbuh/screens/home/home_content.dart';
import 'package:akusitumbuh/screens/menu/menu_content.dart';
import 'package:akusitumbuh/screens/stunting_detection/detection_content.dart';
import 'package:akusitumbuh/screens/team/team_content.dart';
import 'package:akusitumbuh/widgets/gradient_background.dart';
import 'package:akusitumbuh/widgets/logout_alert.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int selectedIndex = 0;
  int menuFilterIndex = -1;

  void goToMenu(int value) {
    setState(() {
      menuFilterIndex = value;
      selectedIndex = 3;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    final allPages = [
      {'icon': Icons.home_filled, 'content': HomeContent(userLevel: userLevel ?? '',)},
      {'icon': Icons.search, 'content': DetectionContent(goToMenu: goToMenu)},
      {'icon': Icons.medical_information, 'content': ListDokterContent()},
      {
        'icon': Icons.restaurant,
        'content': MenuContent(indexResult: menuFilterIndex),
      },
      {'icon': Icons.history, 'content': HistoryContent()},
      {'icon': Icons.groups_2, 'content': TeamContent()},
    ];

    final pages = userLevel == 'Orang Tua'
        ? allPages
        : [allPages[0], allPages[3], allPages[5]];

    if (selectedIndex >= pages.length) {
      selectedIndex = 0;
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        final keluar = await showDialog(
          context: context,
          builder: (_) => LogoutAlert(
            title: 'Keluar Aplikasi',
            subtitle: 'Anda yakin ingin keluar dari aplikasi?',
            onTap: () => Navigator.pop(context, true),
          ),
        );

        if (keluar == true) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GradientBackground(
          child: SafeArea(child: pages[selectedIndex]['content'] as Widget),
        ),
        floatingActionButton: ChatFloating(),
        bottomNavigationBar: _customBottomNavBar(pages),
      ),
    );
  }

  Widget _customBottomNavBar(List<Map<String, dynamic>> pages) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFCCDDFB), Color(0xFFF4D6E6)],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.only(top: 10, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: pages.asMap().entries.map((entry) {
            return _navBarItem(entry.value['icon'] as IconData, entry.key);
          }).toList(),
        ),
      ),
    );
  }

  Widget _navBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () => setState(() {
        selectedIndex = index;
      }),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.circle,
            size: 5,
            color: selectedIndex == index ? Color(0xFFE3BCD1) : Colors.white,
          ),
          Icon(
            icon,
            color: selectedIndex == index
                ? Color(0xFFE3BCD1)
                : Color(0xFFB7C8E8),
            size: 35,
          ),
        ],
      ),
    );
  }
}
