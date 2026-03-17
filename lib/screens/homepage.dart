import 'package:akusitumbuh/screens/home/home_content.dart';
import 'package:akusitumbuh/screens/menu/menu_content.dart';
import 'package:akusitumbuh/screens/stunting_detection/detection_content.dart';
import 'package:akusitumbuh/widgets/gradient_background.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int selectedIndex = 0;

  final pages = [
    {'icon': Icons.home_filled, 'content': HomeContent()},
    {'icon': Icons.search, 'content': DetectionContent()},
    {
      'icon': Icons.medical_information,
      'content': Center(child: Text("Konsultasi")),
    },
    {'icon': Icons.restaurant, 'content': MenuContent()},
    {'icon': Icons.history, 'content': Center(child: Text("History"))},
    {'icon': Icons.person, 'content': Center(child: Text("Profile"))},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GradientBackground(
        content: SafeArea(child: pages[selectedIndex]['content'] as Widget),
      ),
      bottomNavigationBar: _customBottomNavBar(),
    );
  }

  Widget _customBottomNavBar() {
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
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 15,
        ),
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
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
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
