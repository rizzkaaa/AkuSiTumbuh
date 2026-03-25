import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DateInput extends StatefulWidget {
  final String hint;
  final DateTime? initialDate;
  final Function(DateTime)? onDateSelected;

  const DateInput({
    super.key,
    required this.hint,
    this.initialDate,
    this.onDateSelected,
  });

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.initialDate != null) {
      final d = widget.initialDate!;
      _dateController.text =
          '${d.day.toString().padLeft(2, '0')}/'
          '${d.month.toString().padLeft(2, '0')}/'
          '${d.year}';
    }
  }

  @override
  void didUpdateWidget(covariant DateInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialDate != oldWidget.initialDate &&
        widget.initialDate != null) {
      final d = widget.initialDate!;
      _dateController.text =
          '${d.day.toString().padLeft(2, '0')}/'
          '${d.month.toString().padLeft(2, '0')}/'
          '${d.year}';
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 2, now.month, now.day),
      firstDate: DateTime(now.year - 5, now.month, now.day),
      lastDate: DateTime(now.year - 2, now.month, now.day),
    );

    if (picked != null) {
      setState(() {
        _dateController.text =
            '${picked.day.toString().padLeft(2, '0')}/'
            '${picked.month.toString().padLeft(2, '0')}/'
            '${picked.year}';
      });
      widget.onDateSelected?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _dateController,
      readOnly: true,
      onTap: _pickDate,

      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: GoogleFonts.inriaSerif(
          color: const Color(0xFF9472C0).withValues(alpha: 0.5),
          fontSize: 16,
        ),

        suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFFD6A7C9)),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD6A7C9)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD6A7C9)),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
