import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:nourex/core/cache_helper/cache_helper.dart';
import 'package:nourex/core/cache_helper/cache_keys.dart';
import 'package:nourex/core/extensions/log_util.dart';
import 'package:nourex/core/networks_helper/dio_helper/dio_helper.dart';
import 'package:nourex/core/routing/app_router.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/utils/bloc_observer.dart';
import 'package:nourex/nourex_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await setupDependencyInjection();

  await DioHelper.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();

  Bloc.observer = MyBlocObserver();

  AppConstants.userToken = await CacheHelper.getSecuredString(key: CacheKeys.userToken);

  try {
    // await Firebase.initializeApp();
    // await PushNotificationService().initialize();
  } on Exception catch (e) {
    print(e);
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