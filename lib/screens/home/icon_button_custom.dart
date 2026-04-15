import 'package:flutter/material.dart';

class IconButtonCustom extends StatefulWidget {
 final IconData icon;
 final GestureTapCallback onTap;
  const IconButtonCustom({super.key, required this.icon, required this.onTap});

  @override
  State<IconButtonCustom> createState() => _IconButtonCustomState();
}

class _IconButtonCustomState extends State<IconButtonCustom> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Color(0xFFB7C8E8), Color(0xFFF5B6D7)],
            ).createShader(bounds),
            child: Icon(widget.icon, size: 40, color: Color(0xFFE4E9FD)),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF68C3BF),
              ),
              child: Center(child: Text('1', style: TextStyle(fontSize: 10, color: Colors.white),),),
            ),
          ),
        ],
      ),
    );
  }
}