import 'package:flutter/material.dart';

class SettingsDataModel {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  SettingsDataModel({
    required this.iconPath,
    required this.title,
    required this.onTap,
  });
}
