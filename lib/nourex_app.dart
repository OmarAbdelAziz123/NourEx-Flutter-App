import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/routing/app_router.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/features/error/server_error_screen.dart';

class NourExApp extends StatelessWidget {
  const NourExApp({super.key, required this.appRouter, this.token});

  final AppRouter appRouter;
  final String? token;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          ),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'NourEx',
            navigatorKey: AppConstants.navigatorKey,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            builder: EasyLoading.init(),
            initialRoute: Routes.splashScreen,
            // initialRoute: Routes.mainLayoutScreen,
            onGenerateRoute: appRouter.generateRoute,
            // home: ServerErrorScreen(),
          ),
        );
      },
    );
  }
}

class ShowBottomSheetWidget extends StatelessWidget {
  const ShowBottomSheetWidget({super.key});

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          height: 500,
          color: Colors.white,
          child: Center(child: Text('Bottom Sheet')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBottomSheet(context),
      child: Container(
        height: 500,
        width: double.infinity,
        color: Colors.blue,
        child: Center(child: Text("Show Bottom Sheet")),
      ),
    );
  }
}
