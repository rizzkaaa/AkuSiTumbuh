import 'package:akusitumbuh/services/menu_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuContent extends StatefulWidget {
  final int? indexResult;
  const MenuContent({super.key, this.indexResult});

  @override
  State<MenuContent> createState() => _MenuContentState();
}

class _MenuContentState extends State<MenuContent> {
  @override
  Widget build(BuildContext context) {
    final service = MenuService();
    final index = widget.indexResult;

    final menuList = (index != null && index > -1)
        ? service.getMenuByIndex(index)
        : service.getAllMenu();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Text(
                  "Rekomendari Gizi",
                  style: GoogleFonts.jomhuria(
                    wordSpacing: 2,
                    letterSpacing: 1.5,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 5
                      ..color = Color(0xFFCEAABD),
                  ),
                ),
                Text(
                  "Rekomendari Gizi",
                  style: GoogleFonts.jomhuria(
                    wordSpacing: 2,
                    letterSpacing: 1.5,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      border: Border.all(color: Color(0xFFD6A7C9), width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      cursorColor: Color(0xFFE3BCD1),
                      style: GoogleFonts.inriaSerif(
                        color: Color(0xFFD6A7C9),
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        hint: Text(
                          'Cari lebih banyak',
                          style: GoogleFonts.inriaSerif(
                            color: Color(0xFFD6A7C9),
                            fontSize: 16,
                          ),
                        ),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.zero,
                        icon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                            color: Color(0xFFE3BCD1),
                            fontWeight: FontWeight.bold,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD6A7C9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                  ),
                  child: Icon(Icons.tune, color: Color(0xFFFFEAF5), size: 30),
                ),
              ],
            ),

            Expanded(
              child: ListView.builder(
                itemCount: menuList.length,
                itemBuilder: (context, index) {
                  final item = menuList[index];
                  return Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Color(0xFFD6A7C9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Color(0xFFF4D6E6), Colors.white],
                                ),
                              ),
                              child: Text(item.title),
                            ),
                            Row(
                              children: [
                                Icon(Icons.bookmark_border),
                                Icon(Icons.favorite_border),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
