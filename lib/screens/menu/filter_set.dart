import 'package:flutter/material.dart';
import 'package:akusitumbuh/widgets/gradient_border_button.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterSet extends StatefulWidget {
  final int index;
  final Function(int) onApply;

  const FilterSet({super.key, required this.index, required this.onApply});

  @override
  State<FilterSet> createState() => _FilterSetState();
}

class _FilterSetState extends State<FilterSet> {
  int selectedValue = -1;
  List<String> options = [
    "Semua menu makanan",
    "Menu makanan normal",
    "Menu makanan terdeteksi stunting",
    "Menu makanan stunting berat",
  ];

  @override
  void initState() {
    super.initState();
    selectedValue = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF92A7CD), Color(0xFFFFC9E6)],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                ),
                Expanded(
                  child: Text(
                    'Filter Berdasarkan',
                    style: GoogleFonts.libreCaslonText(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: RadioGroup<int>(
                groupValue: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value!;
                  });
                },
                child: Column(
                  children: List.generate(options.length, (i) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(options[i], style: GoogleFonts.lora()),
                        Transform.scale(
                          scale: 1.3,
                          child: Radio<int>(
                            value: i - 1,
                            activeColor: Colors.black,
                            side: BorderSide(color: Colors.black, width: 2),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GradientBorderButton(
                  label: 'Hapus Semua',
                  onTap: () {
                    widget.onApply(-1);
                    Navigator.pop(context);
                  },
                ),
                GradientBorderButton(
                  label: 'Konfirmasi',
                  onTap: () {
                    widget.onApply(selectedValue);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
