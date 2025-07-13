import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nourex/core/cache_helper/cache_helper.dart';
import 'package:nourex/core/cache_helper/cache_keys.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/notification/notifcation_snack_bar.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// لازم تكون Top-Level
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('🔔 Background message received: ${message.messageId}');

  // لو عايز تعرض Local Notification:
  showLocalNotification(message);
}
//
void showLocalNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.max,
    priority: Priority.high,
  );

  const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

  const NotificationDetails platformDetails = NotificationDetails(
    android: androidDetails,
    iOS: iosDetails,
  );

  await flutterLocalNotificationsPlugin.show(
    message.hashCode,
    message.notification?.title,
    message.notification?.body,
    platformDetails,
  );
}
// void showLocalNotification(RemoteMessage message) async {
//   print('🔥 Trying to show notification');
//
//   const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
//     presentAlert: true,
//     presentSound: true,
//     presentBadge: true,
//   );
//
//   print(
//     '🔥 Trying to show notification: ${message.notification?.title} ${message.notification?.body}',
//   );
//
//   // 👇 استخدم التفاصيل دي بدل القديمة
//   const NotificationDetails platformDetails = NotificationDetails(
//     android: AndroidNotificationDetails(
//       'high_importance_channel',
//       'High Importance Notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//     ),
//     iOS: iosDetails,
//   );
//
//   print(
//     '🔥 Trying to show notification22222: ${message.notification?.title} ${message.notification?.body}',
//   );
//
//   await flutterLocalNotificationsPlugin.show(
//     message.hashCode,
//     message.notification?.title ?? 'No Title',
//     message.notification?.body ?? 'No Body',
//     platformDetails,
//   );
//
//   print(
//     '🔥 Trying to show notification33333: ${message.notification?.title} ${message.notification?.body}',
//   );
// }
//
// class PushNotificationService {
//   final _fcm = FirebaseMessaging.instance;
//   String? fCMToken;
//
//   Future<void> initialize() async {
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     await _initLocalNotifications();
//     await _requestPermissions();
//     await _configureFCMListeners();
//
//     fCMToken = await _fcm.getToken();
//     print("✅ FCM Token: $fCMToken");
//     await CacheHelper.saveData(key: CacheKeys.deviceToken, value: fCMToken);
//   }
//
//   Future<void> _initLocalNotifications() async {
//     const AndroidInitializationSettings androidSettings =
//         AndroidInitializationSettings('@drawable/ic_launcher');
//
//     const DarwinInitializationSettings iosSettings =
//         DarwinInitializationSettings();
//
//     const InitializationSettings initSettings = InitializationSettings(
//       android: androidSettings,
//       iOS: iosSettings,
//     );
//
//     await flutterLocalNotificationsPlugin.initialize(
//       initSettings,
//       onDidReceiveNotificationResponse: (response) {
//         print("🔔 Notification tapped: ${response.payload}");
//       },
//     );
//   }
//
//   Future<void> _requestPermissions() async {
//     NotificationSettings settings = await _fcm.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     print("📝 Permission Status: ${settings.authorizationStatus}");
//
//     if (Platform.isIOS) {
//       await FirebaseMessaging.instance
//           .setForegroundNotificationPresentationOptions(
//             alert: true,
//             badge: true,
//             sound: true,
//           );
//     }
//   }
//
//   Future<void> _configureFCMListeners() async {
//     // App opened from notification
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('🔔 App opened via notification: ${message.messageId}');
//       // Navigation or logic here
//     });
//
//     // App in foreground
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('📩 Foreground message: ${message.messageId}');
//       showLocalNotification(message);
//     });
//   }
// }



// Future<void> handleBackgroundMessage(RemoteMessage message) async {}

class PushNotificationService {
  final _fcm = FirebaseMessaging.instance;
  String? fCMToken;

  final _localNotifications = FlutterLocalNotificationsPlugin();
  void handleMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    } else {}
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _localNotifications.initialize(
      settings,
    );
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await _fcm.requestPermission();


    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onMessage.listen((event) {
      final notification = event.notification;
      if (notification == null) return;
      notificationSnackBar(
          context: AppConstants.navigatorKey.currentContext!,
          message: notification.title,
          event: event,
      );
    });
  }

  Future<void> initialize() async {
    if (Platform.isAndroid) {
      _localNotifications
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
          .requestNotificationsPermission();
    }

    if (Platform.isIOS) {
      _localNotifications
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()!
          .requestPermissions(
        alert: true,
        badge: true,
        provisional: false,
        sound: true,
      )
          .then((value) async {
        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
      });
    }

    // 🔑 Request permission and check status
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('✅ User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('⚠️ User granted provisional permission');
    } else {
      print('❌ User declined or has not accepted permission');
    }

    await _fcm.getAPNSToken();
    await Future.delayed(const Duration(seconds: 2));
    fCMToken = await _fcm.getToken();

    if (fCMToken == null) {
      print("❌ FCM Token is null");
    } else {
      print("✅ FCM Token: $fCMToken");
      await CacheHelper.saveData(key: CacheKeys.deviceToken, value: fCMToken);
    }

    await initPushNotifications();
  }


}
