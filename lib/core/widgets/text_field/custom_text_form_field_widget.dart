import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final bool? obscureText;
  final bool? autofocus;
  final bool? autocorrect;
  final bool? enableSuggestions;
  final bool? readOnly;
  final bool? showCursor;
  final Color? cursorColor;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final bool isChat;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final FormFieldSetter<String>? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? enabled;
  final Iterable<String>? autofillHints;
  final EdgeInsets? contentPadding;
  final EdgeInsets? padding;
  final bool? expands;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final VoidCallback? onTap;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double? borderWidth;
  final double? height;
  final double? width;
  final TextAlignVertical? textAlignVertical;
  final FocusNode? focusNode;

  const CustomTextFormFieldWidget({
    super.key,
    this.controller,
    this.isChat = false,
    this.padding,
    this.cursorColor,
    this.textStyle,
    this.hintStyle,
    this.hintText,
    this.width,
    this.labelText,
    this.labelStyle,
    this.backgroundColor,
    this.helperText,
    this.borderColor,
    this.borderWidth,
    this.errorText,
    this.obscureText = false,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.readOnly = false,
    this.showCursor = true,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.validator,
    this.borderRadius,
    this.onSaved,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled,
    this.autofillHints,
    this.contentPadding,
    this.expands,
    this.maxLines,
    this.minLines,
    this.onFieldSubmitted,
    this.buildCounter,
    this.scrollPhysics,
    this.onTap,
    this.height,
    this.textAlignVertical,
    this.textColor,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: textStyle ??
          Styles.contentEmphasis.copyWith(
            color: textColor ?? AppColors.neutralColor1000,
          ),
      autofillHints: autofillHints,
      onTapOutside: isChat ? null : (event) => FocusScope.of(context).unfocus(),
      controller: controller,
      obscureText: obscureText!,
      autofocus: autofocus!,
      autocorrect: autocorrect!,
      focusNode: focusNode,
      enableSuggestions: enableSuggestions!,
      readOnly: readOnly!,
      showCursor: showCursor,
      cursorColor: showCursor == true ? AppColors.primaryColor700 : cursorColor,
      maxLength: maxLength,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      validator: validator,
      onSaved: onSaved,
      inputFormatters: inputFormatters,
      textAlignVertical: textAlignVertical,
      decoration: InputDecoration(
        alignLabelWithHint: true, // Ensures label aligns with hint

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(borderRadius ?? AppConstants.borderRadius - 2.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(borderRadius ?? AppConstants.borderRadius - 2.r),
          borderSide: BorderSide(
            /// TODO: Add border
            color: borderColor ?? AppColors.neutralColor600,
            width: borderWidth ?? .5.sp,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(borderRadius ?? AppConstants.borderRadius - 2.r),
          borderSide: BorderSide(
            /// TODO: Add border
            color: borderColor ?? AppColors.redColor100,
            width: borderWidth ?? 1.sp,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(borderRadius ?? AppConstants.borderRadius - 2.r),
          borderSide: BorderSide(
            color: AppColors.redColor200,
            width: borderWidth ?? 1.sp,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(borderRadius ?? AppConstants.borderRadius - 2.r),
          borderSide: BorderSide(
            color: AppColors.redColor200,
            width: borderWidth ?? 1.sp,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(borderRadius ?? AppConstants.borderRadius),
          borderSide: BorderSide(
            color: borderColor ?? AppColors.neutralColor200,
            width: borderWidth ?? 1.sp,
          ),
        ),
        labelText: labelText,
        labelStyle: labelStyle ??
            Styles.contentEmphasis.copyWith(
              color: AppColors.neutralColor300,
            ),
        hintStyle: hintStyle ?? TextStyle(fontSize: 14.sp, color: AppColors.redColor200),
        hintText: hintText,
        helperText: helperText,
        errorText: errorText,
        prefixIcon: prefixIcon,
        filled: true,
        suffixIcon: suffixIcon,
        prefixIconColor: AppColors.neutralColor1000,
        suffixIconColor: AppColors.neutralColor1000,
        enabled: enabled ?? true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
                horizontal: width ?? 15.w, vertical: height ?? 15.h),
        fillColor: backgroundColor ?? Colors.white,
      ),
      maxLines: isChat ? null : maxLines ?? 1,
      minLines: isChat ? null : minLines,
      onFieldSubmitted: onFieldSubmitted,
      scrollPhysics: scrollPhysics,
      onTap: onTap,
    );
  }
}
