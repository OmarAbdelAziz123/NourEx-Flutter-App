import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AppConstants {
  static String? userToken;
  static String? providerToken;

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static int mainLayoutInitialScreenIndex = 0;

  static screenWidth(context) =>
      MediaQuery
          .sizeOf(context)
          .width;

  static screenHeight(context) =>
      MediaQuery
          .sizeOf(context)
          .height;

  static double borderRadius = 8.r;

  /// Build Error Text
  static String buildErrorText(String message) {
    return Text(
      message,
      style: Styles.contentEmphasis.copyWith(
        color: AppColors.redColor100,
      ),
    ).data!;
  }

  /// Launch URL Function
  static Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  /// Launch Phone Function
  static Future<void> launchPhone(String phone) async {
    // Remove any invisible characters, RTL marks, and extra spaces
    String cleanedPhone = phone.replaceAll(RegExp(r'[^\d+]'), '').trim();

    debugPrint("Trying to launch: $cleanedPhone"); // Debugging output

    final Uri uri = Uri.parse('tel:$cleanedPhone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $cleanedPhone');
    }
  }

  /// Get Profile Image
  static ImageProvider getProfileImage(String? apiImage, String assetImage) {
    if (apiImage != null && apiImage.isNotEmpty) {
      // Priority 1: Image from API saved in local storage
      return NetworkImage(apiImage);
    }

    if (assetImage.isNotEmpty) {
      // Priority 2: Asset image
      return AssetImage(assetImage);
    }

    // Fallback: Default no profile image
    return AssetImage('assets/images/pngs/no_profile_image.png');
  }

  static Future<void> pickTime(BuildContext context,
      TextEditingController controller) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final formattedTime = DateFormat('hh:mm a', 'en_US').format(
        DateTime(
            now.year, now.month, now.day, pickedTime.hour, pickedTime.minute),
      );

      controller.text = formattedTime; // Update text field
    }
  }

  static String removeHtmlTags(String htmlText) {
    final RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }
}
