import 'package:akusitumbuh/screens/auth/input_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class State2 extends StatefulWidget {
  final List<TextEditingController> pendidikanControllers;
  const State2({super.key, required this.pendidikanControllers});

  @override
  State<State2> createState() => _State2State();
}

class _State2State extends State<State2> {
  @override
  Widget build(BuildContext context) {
    final pendidikanControllers = widget.pendidikanControllers;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pendidikan',
          style: GoogleFonts.inriaSerif(
            color: Color(0xFF9472C0).withValues(alpha: 0.5),
            fontSize: 16,
          ),
        ),

        Column(
          children: List.generate(pendidikanControllers.length, (index) {
            int size = pendidikanControllers.length - 1;
            bool isEnd = index == size;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: InputForm(
                      hint: 'Pendidikan ${index + 1}',
                      controller: pendidikanControllers[index],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isEnd && size != 3
                          ? Icons.add_circle_outline
                          : Icons.remove_circle_outline,
                      color: Color(0xFFD6A7C9),
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        if (isEnd && size != 3) {
                          pendidikanControllers.add(TextEditingController());
                        } else {
                          pendidikanControllers.removeAt(index);
                        }
                      });
                    },
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
