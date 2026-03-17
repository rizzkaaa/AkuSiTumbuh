import 'package:flutter/material.dart';

class EducationModel {
  final String title;
  final IconData icon;
  final String description;
  final List? items;
  final String? note;

  EducationModel({
    required this.title,
    required this.icon,
    required this.description,
    this.items,
    this.note,
  });
}
