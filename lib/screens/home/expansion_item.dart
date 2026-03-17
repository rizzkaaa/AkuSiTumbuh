import 'package:akusitumbuh/models/education_model.dart';
import 'package:akusitumbuh/widgets/metal_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpansionItem extends StatelessWidget {
  final int index;
  final EducationModel item;

  const ExpansionItem({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: index % 2 == 0 ? Color(0xFFB7C8E8) : Color(0xFFF4D6E6),
      collapsedBackgroundColor: index % 2 == 0
          ? Color(0xFFB7C8E8)
          : Color(0xFFF4D6E6),
      leading: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          item.icon,
          color: index % 2 == 0 ? Color(0xFF3F5B8F) : Color(0xFFBE4988),
        ),
      ),
      title: Text(
        item.title,
        style: GoogleFonts.merienda(
          color: index % 2 == 0 ? Color(0xFF3F5B8F) : Color(0xFFBE4988),
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        textAlign: TextAlign.center,
      ),
      trailing: Icon(Icons.expand_circle_down_outlined, color: Colors.white),
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: index % 2 == 0 ? Color(0xFFB7C8E8) : Color(0xFFF4D6E6),
              width: 2,
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                MetalText(text: item.description),
                if (item.items != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: item.items!
                          .map((text) => _buildUnorderedList(text))
                          .toList(),
                    ),
                  ),
                if (item.note != null) MetalText(text: item.note!),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUnorderedList(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('• '),
        Expanded(child: MetalText(text: text)),
      ],
    );
  }
}
