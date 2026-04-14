import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const CustomBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(
          onPressed: onPressed ?? () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_rounded, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}
