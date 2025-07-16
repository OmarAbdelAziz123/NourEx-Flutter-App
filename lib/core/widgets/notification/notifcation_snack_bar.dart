import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void notificationSnackBar({
  required BuildContext context,
  required String? message,
  required RemoteMessage event
}) {
  // Extract notification data
  final title = message ?? event.notification?.title ?? "New Notification";
  final body = event.data["body"] ?? event.notification?.body ?? "";
  final imageUrl = event.data["image"] ?? "";

  // Show custom top snackbar with professional design
  showTopSnackBar(
    Overlay.of(context),
    Material(
      elevation: 0,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 24,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
          border: Border.all(
            color: Colors.grey.withOpacity(0.1),
            width: 0.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Icon with modern design
            Container(
              height: 44.h,
              width: 44.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryColor400,
                    AppColors.primaryColor600,
                  ],
                ),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor400.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "N",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // Notification Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // App name and time row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Noorex",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "now",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  // Title
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Body
                  if (body.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Text(
                      body,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  // Image if available
                  if (imageUrl.isNotEmpty) ...[
                    SizedBox(height: 12.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.network(
                        imageUrl,
                        height: 100.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(height: 0),
                      ),
                    ),
                  ],

                  // Action buttons (optional)
                  if (event.data.containsKey("action_buttons")) ...[
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Handle dismiss action
                            _dismissNotification(context);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            "Dismiss",
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        ElevatedButton(
                          onPressed: () {
                            _handleNotificationTap(context, event);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor500,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            "View",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Close button with modern design
            GestureDetector(
              onTap: () => _dismissNotification(context),
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(
                  Icons.close,
                  size: 16.sp,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    dismissDirection: [
      DismissDirection.up,
      DismissDirection.horizontal,
    ],
    curve: Curves.easeOutCubic,
    displayDuration: const Duration(seconds: 5),
    dismissType: DismissType.onSwipe,
    onTap: () => _handleNotificationTap(context, event),
  );
}

// Helper function to dismiss notification
void _dismissNotification(BuildContext context) {
  final OverlayState overlay = Overlay.of(context);
  final OverlayEntry? entry = overlay.mounted
      ? ModalRoute.of(context)?.overlayEntries.lastOrNull
      : null;
  if (entry != null) {
    entry.remove();
  }
}

// Helper function to handle notification tap
void _handleNotificationTap(BuildContext context, RemoteMessage event) {
  // Dismiss the notification first
  _dismissNotification(context);

  // Handle navigation based on notification data
  if (event.data.containsKey("route")) {
    final route = event.data["route"];
    Navigator.of(context).pushNamed(route);
  } else if (event.data.containsKey("screen")) {
    final screen = event.data["screen"];
    // Add your navigation logic here
    switch (screen) {
      case "home":
        Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
        break;
      case "profile":
        Navigator.of(context).pushNamed("/profile");
        break;
      case "offers":
        Navigator.of(context).pushNamed("/offers");
        break;
      default:
      // Navigate to main screen
        Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
    }
  }
}

// Alternative version with iOS-style design
void iosStyleNotificationSnackBar({
  required BuildContext context,
  required String? message,
  required RemoteMessage event
}) {
  final title = message ?? event.notification?.title ?? "New Notification";
  final body = event.data["body"] ?? event.notification?.body ?? "";
  final imageUrl = event.data["image"] ?? "";

  showTopSnackBar(
    Overlay.of(context),
    Material(
      elevation: 0,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 0.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Icon
            Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor400,
                    AppColors.primaryColor600,
                  ],
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Text(
                  "N",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // App name
                  Text(
                    "Nourex",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2.h),

                  // Title
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Body
                  if (body.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(
                      body,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[600],
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),

            // Time
            Text(
              "now",
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    ),
    dismissDirection: [DismissDirection.up, DismissDirection.horizontal],
    curve: Curves.easeOutQuart,
    displayDuration: const Duration(seconds: 4),
    dismissType: DismissType.onSwipe,
    onTap: () => _handleNotificationTap(context, event),
  );
}

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:nourex/core/themes/app_colors.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';
//
// void notificationSnackBar({
//   required BuildContext context,
//   required String? message,
//   required RemoteMessage event
// }) {
//   // Extract notification data
//   final title = message ?? event.notification?.title ?? "New Notification";
//   final body = event.data["body"] ?? event.notification?.body ?? "";
//   final imageUrl = event.data["image"] ?? "";
//
//   // Show custom top snackbar
//   showTopSnackBar(
//     Overlay.of(context),
//     Material(
//       elevation: 6,
//       shadowColor: Colors.black26,
//       borderRadius: BorderRadius.circular(12.r),
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.r),
//           border: Border.all(color: AppColors.primaryColor200.withOpacity(0.3), width: 1),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Notification Icon with bubble effect
//             Container(
//               height: 42.h,
//               width: 42.w,
//               decoration: BoxDecoration(
//                 color: AppColors.primaryColor100,
//                 shape: BoxShape.circle,
//               ),
//               child: Center(
//                 child: Icon(
//                   Icons.notifications_active,
//                   color: AppColors.primaryColor800,
//                   size: 22.sp,
//                 ),
//               ),
//             ),
//             SizedBox(width: 12.w),
//
//             // Notification Content
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Title
//                   Text(
//                     title,
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   SizedBox(height: 4.h),
//
//                   // Body
//                   if (body.isNotEmpty) ...[
//                     Text(
//                       body,
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: Colors.black54,
//                         height: 1.2,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     SizedBox(height: 4.h),
//                   ],
//
//                   // Image if available
//                   if (imageUrl.isNotEmpty) ...[
//                     SizedBox(height: 4.h),
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(8.r),
//                       child: Image.network(
//                         imageUrl,
//                         height: 120.h,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) =>
//                             Container(height: 0),
//                       ),
//                     ),
//                   ],
//
//                   // Time indicator
//                   SizedBox(height: 4.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         "Now",
//                         style: TextStyle(
//                           fontSize: 11.sp,
//                           color: Colors.black38,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//             // Close button
//             GestureDetector(
//               onTap: () {
//                 // Find the closest snack bar in the overlay and close it
//                 final OverlayState overlay = Overlay.of(context);
//                 final OverlayEntry? entry =
//                 overlay.mounted ? ModalRoute.of(context)?.overlayEntries.lastOrNull : null;
//                 if (entry != null) {
//                   entry.remove();
//                 }
//               },
//               child: Padding(
//                 padding: EdgeInsets.only(left: 8.w),
//                 child: Icon(
//                   Icons.close,
//                   size: 16.sp,
//                   color: Colors.black45,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//     dismissDirection: [
//       DismissDirection.up,
//       DismissDirection.horizontal,
//     ],
//     curve: Curves.easeOutQuart,
//     displayDuration: const Duration(seconds: 4),
//     dismissType: DismissType.onSwipe,
//     onTap: () {
//       // Handle notification tap - you can navigate to a specific screen based on data
//       if (event.data.containsKey("route")) {
//         final route = event.data["route"];
//         Navigator.of(context).pushNamed(route);
//       }
//     },
//   );
// }