import 'package:flutter/material.dart';
class LegendCard extends StatelessWidget {
  const LegendCard({super.key});

  static const _levels = [
    ('< 20%', Color(0xFFFFEBEE), 'Rendah'),
    ('20–29%', Color(0xFFEF9A9A), 'Sedang'),
    ('30–34%', Color(0xFFE57373), 'Tinggi'),
    ('≥ 35%', Color(0xFFB71C1C), 'Sangat Tinggi'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.93),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Tingkat Stunting',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          for (final lvl in _levels) ...[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: lvl.$2,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '${lvl.$1}  ${lvl.$3}',
                  style: const TextStyle(fontSize: 9.5),
                ),
              ],
            ),
            const SizedBox(height: 4),
          ],
        ],
      ),
    );
  }
}