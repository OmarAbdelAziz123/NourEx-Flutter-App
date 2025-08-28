// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:nourex/core/themes/app_colors.dart';
// // import 'package:nourex/core/themes/text_colors.dart';
// // import 'package:nourex/features/products/data/models/variant_option.dart';
//
// // class CustomVariantColumnWidget extends StatefulWidget {
// //   const CustomVariantColumnWidget({
// //     super.key,
// //     required this.variantName,
// //     required this.options,
// //     this.isColored = false,
// //     this.selectedId,
// //     this.onSelectionChanged,
// //   });
//
// //   final String variantName;
// //   final List<VariantOption> options;
// //   final bool isColored;
// //   final String? selectedId;
// //   final Function(String selectedId)? onSelectionChanged;
//
// //   @override
// //   State<CustomVariantColumnWidget> createState() =>
// //       _CustomVariantColumnWidgetState();
// // }
//
// // class _CustomVariantColumnWidgetState extends State<CustomVariantColumnWidget> {
// //   String? selectedId;
//
// //   @override
// //   void initState() {
// //     super.initState();
// //     selectedId = widget.selectedId;
// //   }
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         /// Title aligned to the right (RTL)
// //         Align(
// //           alignment: Alignment.centerRight,
// //           child: Text(widget.variantName, style: Styles.contentEmphasis),
// //         ),
// //         SizedBox(height: 8.h),
//
// //         /// Options row - RTL alignment (right to left)
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.start,
// //           children:
// //           widget.options.reversed.map((option) {
// //             return Padding(
// //               padding: EdgeInsets.only(left: 6.w),
// //               child: _buildOptionItem(option),
// //             );
// //           }).toList(),
// //         ),
// //       ],
// //     );
// //   }
//
// //   Widget _buildOptionItem(VariantOption option) {
// //     final isSelected = selectedId == option.id;
// //     final isDisabled = !option.isAvailable;
//
// //     return GestureDetector(
// //       onTap: isDisabled ? null : () => _onOptionTap(option.id),
// //       child: Container(
// //         width: widget.isColored ? 32.w : null,
// //         height: 32.h,
// //         padding:
// //         widget.isColored
// //             ? EdgeInsets.zero
// //             : EdgeInsets.symmetric(horizontal: 12.w),
// //         decoration: BoxDecoration(
// //           color: _getBackgroundColor(option, isSelected, isDisabled),
// //           borderRadius: BorderRadius.circular(6.r),
// //           border:
// //           isSelected
// //               ? Border.all(color: Colors.transparent, width: 0)
// //               : Border.all(color: const Color(0xFFE5E5E5), width: 1.w),
// //         ),
// //         child: _buildOptionContent(option, isSelected, isDisabled),
// //       ),
// //     );
// //   }
//
// //   Widget _buildOptionContent(
// //       VariantOption option,
// //       bool isSelected,
// //       bool isDisabled,
// //       ) {
// //     if (widget.isColored && option.color != null) {
// //       // Color variant design - exact match to image
// //       return Container(
// //         decoration: BoxDecoration(
// //           color: option.color,
// //           borderRadius: BorderRadius.circular(6.r),
// //         ),
// //         child:
// //         isSelected
// //             ? Center(
// //           child: Icon(Icons.check, color: Colors.white, size: 14.sp),
// //         )
// //             : null,
// //       );
// //     }
//
// //     /// Size variant design - exact match to image
// //     return Center(
// //       child: Text(
// //         option.label,
// //         style: Styles.contentRegular.copyWith(
// //           color: _getTextColor(isSelected, isDisabled),
// //         ),
// //       ),
// //     );
// //   }
//
// //   Color _getBackgroundColor(
// //       VariantOption option,
// //       bool isSelected,
// //       bool isDisabled,
// //       ) {
// //     if (widget.isColored) {
// //       /// For color variants, background is the color itself
// //       return option.color ?? Colors.grey;
// //     }
//
// //     /// For size variants - exact colors from image
// //     if (isDisabled) {
// //       return const Color(0xFFF5F5F5);
// //     }
// //     if (isSelected) {
// //       return const Color(0xFF2C3E50);
//
// //       /// Dark navy blue for selected size
// //     }
// //     return const Color(0xFFF8F9FA);
//
// //     /// Light gray for unselected sizes
// //   }
//
// //   Color _getTextColor(bool isSelected, bool isDisabled) {
// //     if (isDisabled) {
// //       return AppColors.neutralColor100;
// //     }
// //     if (isSelected) {
// //       return AppColors.neutralColor100;
// //     }
// //     return AppColors.neutralColor1000;
// //   }
//
// //   void _onOptionTap(String optionId) {
// //     setState(() {
// //       selectedId = optionId;
// //     });
// //     widget.onSelectionChanged?.call(optionId);
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:nourex/core/themes/app_colors.dart';
// import 'package:nourex/core/themes/text_colors.dart';
// import 'package:nourex/features/products/data/models/variant_option.dart';
//
// class CustomVariantColumnWidget extends StatefulWidget {
//   const CustomVariantColumnWidget({
//     super.key,
//     required this.variantName,
//     required this.options,
//     this.isColored = false,
//     this.selectedId,
//     this.onSelectionChanged,
//     this.onSelect, // NEW
//   });
//
//   final String variantName;
//   final List<VariantOption> options;
//   final bool isColored;
//   final String? selectedId;
//   final Function(String selectedId)? onSelectionChanged;
//
//   /// New: Call this with variantType and selected option id
//   final Function(String variantType, String selectedId)? onSelect;
//
//   @override
//   State<CustomVariantColumnWidget> createState() =>
//       _CustomVariantColumnWidgetState();
// }
//
// class _CustomVariantColumnWidgetState extends State<CustomVariantColumnWidget> {
//   String? selectedId;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedId = widget.selectedId;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Align(
//           alignment: Alignment.centerRight,
//           child: Text(widget.variantName, style: Styles.contentEmphasis),
//         ),
//         SizedBox(height: 8.h),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: widget.options.reversed.map((option) {
//             return Padding(
//               padding: EdgeInsets.only(left: 6.w),
//               child: _buildOptionItem(option),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildOptionItem(VariantOption option) {
//     final isSelected = selectedId == option.id;
//     final isDisabled = !option.isAvailable;
//
//     return GestureDetector(
//       onTap: isDisabled ? null : () => _onOptionTap(option.id),
//       child: Container(
//         width: widget.isColored ? 32.w : null,
//         height: 32.h,
//         padding: widget.isColored
//             ? EdgeInsets.zero
//             : EdgeInsets.symmetric(horizontal: 12.w),
//         decoration: BoxDecoration(
//           color: _getBackgroundColor(option, isSelected, isDisabled),
//           borderRadius: BorderRadius.circular(6.r),
//           border: isSelected
//               ? Border.all(color: Colors.transparent, width: 0)
//               : Border.all(color: const Color(0xFFE5E5E5), width: 1.w),
//         ),
//         child: _buildOptionContent(option, isSelected, isDisabled),
//       ),
//     );
//   }
//
//   Widget _buildOptionContent(
//       VariantOption option, bool isSelected, bool isDisabled) {
//     if (widget.isColored && option.color != null) {
//       return Container(
//         decoration: BoxDecoration(
//           color: option.color,
//           borderRadius: BorderRadius.circular(6.r),
//         ),
//         child: isSelected
//             ? Center(
//                 child: Icon(Icons.check, color: Colors.white, size: 14.sp),
//               )
//             : null,
//       );
//     }
//
//     return Center(
//       child: Text(
//         option.label,
//         style: Styles.contentRegular.copyWith(
//           color: _getTextColor(isSelected, isDisabled),
//         ),
//       ),
//     );
//   }
//
//   Color _getBackgroundColor(
//       VariantOption option, bool isSelected, bool isDisabled) {
//     if (widget.isColored) {
//       return option.color ?? Colors.grey;
//     }
//
//     if (isDisabled) {
//       return const Color(0xFFF5F5F5);
//     }
//     if (isSelected) {
//       return const Color(0xFF2C3E50);
//     }
//     return const Color(0xFFF8F9FA);
//   }
//
//   Color _getTextColor(bool isSelected, bool isDisabled) {
//     if (isDisabled) return AppColors.neutralColor100;
//     if (isSelected) return AppColors.neutralColor100;
//     return AppColors.neutralColor1000;
//   }
//
//   void _onOptionTap(String optionId) {
//     setState(() {
//       selectedId = optionId;
//     });
//
//     // Fire both optional callbacks
//     widget.onSelectionChanged?.call(optionId);
//
//     if (widget.onSelect != null) {
//       widget.onSelect!(widget.variantName, optionId);
//     }
//   }
// }
