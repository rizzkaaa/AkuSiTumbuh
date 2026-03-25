import 'package:akusitumbuh/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RattingDialog extends StatefulWidget {
  const RattingDialog({super.key});

  @override
  State<RattingDialog> createState() => _RattingDialogState();
}

class _RattingDialogState extends State<RattingDialog> {
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: 320,
            margin: const EdgeInsets.only(top: 36),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(50),
                bottom: Radius.circular(20),
              ),
              gradient: LinearGradient(
                colors: [Color(0xFF92A7CD), Color(0xFFFFC9E6)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: Offset(5, 10),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      final starIndex = index + 1;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedRating = starIndex;
                          });
                        },
                        child: _StarIcon(
                          filled: starIndex <= _selectedRating,
                          size: starIndex == 3
                              ? 58
                              : (starIndex == 2 || starIndex == 4 ? 50 : 44),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 28),

                  GradientButton(
                    label: 'Kirim',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Rating dikirim",
                            style: GoogleFonts.inriaSerif(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: const Color.fromARGB(
                            255,
                            164,
                            183,
                            214,
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -10,
            left: -50,
            right: -50,
            child: Image.asset('assets/images/ribbon_banner.png', width: 300),
          ),
        ],
      ),
    );
  }
}

class _StarIcon extends StatelessWidget {
  final bool filled;
  final double size;

  const _StarIcon({required this.filled, required this.size});

  @override
  Widget build(BuildContext context) {
    return Icon(
      filled ? Icons.star : Icons.star_border,
      size: size,
      color: filled ? const Color(0xFFFFB800) : const Color(0xFFE8B4CB),
    );
  }
}
