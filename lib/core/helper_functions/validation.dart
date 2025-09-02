import 'package:easy_localization/easy_localization.dart';

class AppValidator {
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '${fieldName?.tr()} validation.required'.tr();
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation.address.required'.tr();
    } else {
      return null;
    }
  }

  static String? validateNote(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation.note.required'.tr();
    } else {
      return null;
    }
  }

  static String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation.city.required'.tr();
    } else {
      return null;
    }
  }

  static String? validateZone(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation.zone.required'.tr();
    } else {
      return null;
    }
  }

  static String? validateStreet(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation.street.required'.tr();
    } else {
      return null;
    }
  }

  static String? validateBuildingNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation.building_number.required'.tr();
    } else {
      return null;
    }
  }
  static String? validateApartmentNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation.apartment_number.required'.tr();
    } else {
      return null;
    }
  }

  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'validation.username.required'.tr();
    }

    if (username.length < 3) {
      return 'validation.username.minLength'.tr();
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation.email.required'.tr();
    }

    final emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'validation.email.invalid'.tr();
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation.password.required'.tr();
    }

    if (value.length < 6) {
      return 'validation.password.minLength'.tr();
    }


    return null;
  }

  /// Validate New Password
  static String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation.password.required'.tr();
    }

    if (value.length < 6) {
      return 'validation.password.minLength'.tr();
    }

    return null;
  }

  /// Validate Confirm New Password
  static String? validateConfirmNewPassword(String? confirmPassword, String? newPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'validation.confirmPassword.required'.tr();
    }

    if (confirmPassword.length < 6) {
      return 'validation.password.minLength'.tr();
    }

    if (confirmPassword != newPassword) {
      return 'validation.confirmPassword.notMatch'.tr();
    }

    return null;
  }

  static String? validateConfirmPassword(
      String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'validation.confirmPassword.required'.tr();
    }

    if (password != confirmPassword) {
      return 'validation.confirmPassword.mismatch'.tr();
    }

    return null;
  }

  static String? validateSaudiPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation.phone.required'.tr();
    }

    final phoneRegExp = RegExp(r'^[0-9]{9}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'validation.phone.invalid'.tr();
    }

    return null;
  }

  static String? validateEgyptPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation.phone.required'.tr();
    }

    final phoneRegExp = RegExp(r'^(010|011|012|015)[0-9]{8}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'validation.phone.invalid'.tr();
    }

    return null;
  }

  // static String? validateSyrianPhoneNumber(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return 'validation.phone.required'.tr();
  //   }
  //
  //   final cleaned = value.trim().replaceAll(RegExp(r'\s+'), '');
  //
  //   // يسمح بـ +963، 00963، 963، 0 أو لا شيء قبل 9XXXXXXXX
  //   final phoneRegExp = RegExp(r'^(00963|963|\+963|0)?9\d{8}$');
  //
  //   if (!phoneRegExp.hasMatch(cleaned)) {
  //     return 'validation.phone.invalid'.tr();
  //   }
  //
  //   return null;
  // }
  static String? validateSyrianPhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validation.phone.required'.tr();
    }

    String cleaned = value.trim().replaceAll(RegExp(r'\s+'), '');

    // الصيغة المسموحة: 09xxxxxxxx أو 9xxxxxxxx أو +9639xxxxxxxx أو 009639xxxxxxxx أو 9639xxxxxxxx
    final phoneRegExp = RegExp(r'^(?:\+963|00963|963|0)?9\d{8}$');

    if (!phoneRegExp.hasMatch(cleaned)) {
      return 'validation.phone.invalid'.tr();
    }

    return null;
  }

  /// ✅ Helper to return always normalized format: +9639xxxxxxxx
  static String formatSyrianPhoneNumber(String value) {
    String cleaned = value.trim().replaceAll(RegExp(r'\s+'), '');

    if (cleaned.startsWith('0')) {
      cleaned = cleaned.substring(1); // يشيل الـ 0
    }
    if (cleaned.startsWith('00963')) {
      cleaned = cleaned.substring(5);
    }
    if (cleaned.startsWith('963')) {
      cleaned = cleaned.substring(3);
    }
    if (cleaned.startsWith('+963')) {
      return cleaned; // جاهز
    }

    return '+963$cleaned';
  }



  static String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation.otp.required'.tr();
    }

    if (!RegExp(r'^\d{6}$').hasMatch(value)) {
      return 'validation.otp.invalid'.tr();
    }

    return null;
  }
}
