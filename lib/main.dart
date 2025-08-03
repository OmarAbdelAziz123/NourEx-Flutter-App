import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:nourex/core/cache_helper/cache_helper.dart';
import 'package:nourex/core/cache_helper/cache_keys.dart';
import 'package:nourex/core/extensions/log_util.dart';
import 'package:nourex/core/networks_helper/dio_helper/dio_helper.dart';
import 'package:nourex/core/routing/app_router.dart';
import 'package:nourex/core/services/di/di.dart';
import 'package:nourex/core/services/firebase/fcm.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/utils/bloc_observer.dart';
import 'package:nourex/firebase_options.dart';
import 'package:nourex/nourex_app.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("📩 Background message: ${message.messageId}");
  // optional: تعمل Local notification هنا لو عايز
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencyInjection();
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await DioHelper.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();

  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // أو أي لون تريده للأعلى
      statusBarIconBrightness: Brightness.dark, // للون أيقونات الشريط العلوي
      systemNavigationBarColor: Colors.white, // ✅ هنا تغيير شريط التنقل السفلي
      systemNavigationBarIconBrightness: Brightness.dark, // لون الأيقونات (أسود مثلاً)
    ),
  );

  // await CacheHelper.clearAllSecuredData();
  // await CacheHelper.clearAllData();

  Bloc.observer = MyBlocObserver();

  AppConstants.userToken = await CacheHelper.getSecuredString(key: CacheKeys.userToken);
  try {
    await PushNotificationService().initialize();
  } on Exception catch (e) {
    print("Firebase error: $e");
  }

  logSuccess(
    "userToken: ${AppConstants.userToken}",
  );
  logSuccess(
    "Fcm: ${CacheHelper.getData(key: CacheKeys.deviceToken)}",
  );

  runApp(EasyLocalization(
    saveLocale: true,
    useFallbackTranslations: true,
    fallbackLocale: const Locale('ar', 'EG'),
    startLocale: const Locale('ar', 'EG'),
    supportedLocales: const [
      Locale('ar', 'EG'),
      Locale('en', 'UK'),
    ],
    path: 'assets/languages',
    child: Phoenix(
      child: NourExApp(
        appRouter: AppRouter(),
        token: AppConstants.userToken,
      ),
    ),
  ));
}