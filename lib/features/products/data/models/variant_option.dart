import 'dart:ui';

import 'package:flutter/material.dart';
//
// /// Model for variant options
// class VariantOption {
//   final String id;
//   final String label;
//   final Color? color;
//   final bool isAvailable;
//
//   VariantOption({
//     required this.id,
//     required this.label,
//     this.color,
//     this.isAvailable = true,
//   });
// }
class VariantOption {
  final String id;
  final String label;
  final Color? color;

  VariantOption({required this.id, required this.label, this.color});
}

List<VariantOption> _generateVariantOptions(List<String> values, String type) {
  return values.map((v) {
    Color? color;
    if (type.toLowerCase().contains("color") || type.toLowerCase().contains("لون")) {
      try {
        color = _parseColor(v); // you can implement parsing hex/color names
      } catch (_) {}
    }
    return VariantOption(id: v, label: v, color: color);
  }).toList();
}

Color? _parseColor(String value) {
  if (value.isEmpty) return null;

  // ✅ If value is a hex code (#RRGGBB or RRGGBB)
  String hex = value.replaceAll("#", "").toUpperCase();
  if (RegExp(r'^[0-9A-F]{6}$').hasMatch(hex)) {
    return Color(int.parse("FF$hex", radix: 16)); // Add alpha (FF = fully opaque)
  }

  // ✅ If value is a known color name
  switch (value.toLowerCase().trim()) {
    case "red":
    case "أحمر":
      return Colors.red;
    case "blue":
    case "أزرق":
      return Colors.blue;
    case "green":
    case "أخضر":
      return Colors.green;
    case "black":
    case "أسود":
      return Colors.black;
    case "white":
    case "أبيض":
      return Colors.white;
    case "yellow":
    case "أصفر":
      return Colors.yellow;
    case "grey":
    case "gray":
    case "رمادي":
      return Colors.grey;
  }

  // ❌ Unknown value
  return Colors.grey; // fallback
}
