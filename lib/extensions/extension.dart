import 'dart:convert';

import 'package:flutter/material.dart';

extension TimeOfDayFormat on TimeOfDay {
  String toHHmm() {
    final hour = this.hour.toString().padLeft(2, '0');
    final minute = this.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }
}

extension TimeFormatID on DateTime {
  String toFormatID() {
    const bulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return "$day ${bulan[month - 1]} $year";
  }
}

extension Base64ImageExtension on String? {
  ImageProvider toImageProvider({
    ImageProvider fallback = const AssetImage('assets/images/default-profile.png'),
  }) {
    if (this == null || this!.isEmpty) {
      return fallback;
    }

    try {
      return MemoryImage(base64Decode(this!));
    } catch (_) {
      return fallback;
    }
  }
}

extension DateTimeFormat on DateTime? {
  String toTime() {
    if (this == null) return '';
    final hour = this!.hour.toString().padLeft(2, '0');
    final minute = this!.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }
}

extension StringCasingExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  String capitalizeWords() {
    return split(' ')
        .map((word) => word.isEmpty
            ? word
            : word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}