import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeInput extends StatefulWidget {
  final String hint;
  final TimeOfDay? initialTime;
  final Function(TimeOfDay)? onTimeSelected;

  const TimeInput({
    super.key,
    required this.hint,
    this.initialTime,
    this.onTimeSelected,
  });

  @override
  State<TimeInput> createState() => _TimeInputState();
}

class _TimeInputState extends State<TimeInput> {
  final TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.initialTime != null) {
      final hour = widget.initialTime!.hour.toString().padLeft(2, '0');
      final minute = widget.initialTime!.minute.toString().padLeft(2, '0');
      _timeController.text = '$hour:$minute';
    }
  }

  @override
  void didUpdateWidget(covariant TimeInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialTime != oldWidget.initialTime &&
        widget.initialTime != null) {
      final hour = widget.initialTime!.hour.toString().padLeft(2, '0');
      final minute = widget.initialTime!.minute.toString().padLeft(2, '0');
      _timeController.text = '$hour:$minute';
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        final hour = picked.hour.toString().padLeft(2, '0');
        final minute = picked.minute.toString().padLeft(2, '0');
        _timeController.text = '$hour:$minute';
      });
      widget.onTimeSelected?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _timeController,
      readOnly: true,
      onTap: _pickTime,
      style: GoogleFonts.libreCaslonText(
        fontSize: 16,
        color: const Color(0xFF9472C0),
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: GoogleFonts.inriaSerif(
          color: const Color(0xFF9472C0).withValues(alpha: 0.5),
          fontSize: 14,
        ),
        hintMaxLines: 2,
        suffixIcon: const Icon(Icons.access_time, color: Color(0xFFD6A7C9)),
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
