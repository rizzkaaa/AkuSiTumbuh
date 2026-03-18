import 'package:akusitumbuh/models/menu_model.dart';
import 'package:akusitumbuh/screens/menu/detail_menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardMenu extends StatefulWidget {
  final MenuModel item;
  final int index;
  const CardMenu({super.key, required this.item, required this.index});

  @override
  State<CardMenu> createState() => _CardMenuState();
}

class _CardMenuState extends State<CardMenu> {
  bool isLiked = false;
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final pink = widget.index % 2 == 0;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.centerLeft,
      children: [
        Row(
          children: [
            const SizedBox(width: 60),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: pink ? Color(0xFFD6A7C9) : Color(0xFF92A6CD),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    _buildLabel(item.title, pink),
                    _buildAction(pink, item),
                  ],
                ),
              ),
            ),
          ],
        ),

        _buildImgLabel(item.image),
      ],
    );
  }

  Widget _buildImgLabel(String image) {
    return Positioned(
      left: -10,
      child: Image.asset(
        'assets/images/menu/$image',
        width: 150,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildLabel(String label, bool pink) {
    return Expanded(
      child: Container(
        constraints: BoxConstraints(minHeight: 60),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              pink ? Color(0xFFF4D6E6) : Color(0xFFD6E1F4),
              Colors.white,
            ],
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 70),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.libreBodoni(
                  color: pink ? Color(0xFF996781) : Color(0xFF697CA1),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(bool pink, MenuModel item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIcon(
          pink: pink,
          icon: Icons.info_outline,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailMenu(item: item, pink: pink),
            ),
          ),
        ),
        _buildIcon(
          pink: pink,
          icon: isLiked ? Icons.favorite : Icons.favorite_border,
          onPressed: () {
            setState(() {
              isLiked = !isLiked;
            });
          },
        ),
      ],
    );
  }

  Widget _buildIcon({
    required bool pink,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: pink ? Color(0xFFF4D6E6) : Color(0xFFD6E1F4)),
    );
  }
}
