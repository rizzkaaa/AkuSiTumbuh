import 'package:akusitumbuh/widgets/metal_text.dart';
import 'package:flutter/material.dart';

class UnorderedList extends StatelessWidget {
  final String text;
  const UnorderedList({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
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
