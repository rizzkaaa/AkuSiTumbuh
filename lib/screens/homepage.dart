import 'package:akusitumbuh/screens/chatbot/welcome_screen.dart';
import 'package:akusitumbuh/screens/home/home_content.dart';
import 'package:akusitumbuh/screens/menu/menu_content.dart';
import 'package:akusitumbuh/screens/stunting_detection/detection_content.dart';
import 'package:akusitumbuh/widgets/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart' as inset;

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

  @override
  Widget build(BuildContext context) {
    final pages = [
      {'icon': Icons.home_filled, 'content': HomeContent()},
      {'icon': Icons.search, 'content': DetectionContent(goToMenu: goToMenu)},
      {
        'icon': Icons.medical_information,
        'content': Center(child: Text("Konsultasi")),
      },
      {
        'icon': Icons.restaurant,
        'content': MenuContent(indexResult: menuFilterIndex),
      },
      {'icon': Icons.history, 'content': Center(child: Text("History"))},
      {'icon': Icons.person, 'content': Center(child: Text("Profile"))},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: GradientBackground(
        content: SafeArea(child: pages[selectedIndex]['content'] as Widget),
      ),
      floatingActionButton: Container(
        decoration: inset.BoxDecoration(
          boxShadow: [
            inset.BoxShadow(
              color: Color(0xFF000000).withValues(alpha: 0.25,)
              ,offset: Offset(4, -4), blurRadius: 4, inset: true
            )
          ],
          color: Color(0xFFF4D6E6),
          borderRadius: BorderRadius.circular(10)
        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.transparent,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          ),
          child: Image.asset('assets/images/icon_bot.png', width: 40,),
        ),
      ),
      bottomNavigationBar: _customBottomNavBar(pages),
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
