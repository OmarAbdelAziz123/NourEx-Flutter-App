// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';
//
// notificationSnackBar(
//     {required context, required message, required RemoteMessage event}) {
//   showTopSnackBar(
//     Overlay.of(context),
//     CustomSnackBar.success(
//       message: "$message\n ${event.data["body"] ?? ""}",
//       backgroundColor: AppColors.primaryColor800,
//
//       messagePadding: EdgeInsets.only(left: 5.w),
//       icon: Padding(
//           padding: EdgeInsetsDirectional.symmetric(horizontal: 5.w),
//           child: const Icon(Icons.notifications)),
//     ),
//     dismissDirection: [
//       DismissDirection.vertical,
//       DismissDirection.horizontal,
//     ],
//     curve: Curves.fastLinearToSlowEaseIn,
//     displayDuration: const Duration(seconds: 3),
//     dismissType: DismissType.onTap,
//   );
// }
