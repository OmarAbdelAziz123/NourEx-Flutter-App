import 'package:flutter/material.dart';

class NourExApp extends StatelessWidget {
  const NourExApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NourEx',
      // navigatorKey: AppConstants.navigatorKey,
      // themeMode: ThemeMode.light,
      // onGenerateRoute: appRouter.generateRoute,
      // initialRoute: Routes.splashScreen,
      // builder: EasyLoading.init(),
      home: const Scaffold(
        body: Center(
          child: Text('NourEx'),
        ),
      ),
    );
  }
}
