import 'dart:ui';

/// Model for variant options
class VariantOption {
  final String id;
  final String label;
  final Color? color;
  final bool isAvailable;

  VariantOption({
    required this.id,
    required this.label,
    this.color,
    this.isAvailable = true,
  });
}