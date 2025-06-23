import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/features/home/screens/home_screen.dart';
import 'package:nourex/features/main_layout/bloc/main_layout_cubit.dart';
import 'package:nourex/features/main_layout/presentation/main_layout.dart';
import 'package:nourex/features/profile/screens/profile_screen.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    PageTransition transition<T extends Cubit<Object>>({
      required Widget screen,
      T? cubit,
      Object? arguments,
      PageTransitionType type = PageTransitionType.fade,
      Duration duration = const Duration(milliseconds: 200),
      Alignment alignment = Alignment.center,
    }) {
      final child = cubit != null
          ? BlocProvider<T>(
              create: (context) => cubit,
              child: screen,
            )
          : screen;

      return PageTransition(
        child: child,
        type: type,
        duration: duration,
        alignment: alignment,
        settings: settings,
      );
    }

    switch (settings.name) {
      case Routes.homeScreen:
        return transition(
          screen: const HomeScreen(),
        );
      case Routes.profileScreen:
        return transition(
          screen: const ProfileScreen(),
        );
      case Routes.mainLayoutScreen:
        return transition(
          screen: const UserMainLayout(),
          cubit: MainLayoutCubit(),
        );
    }
  }

  List<Widget> userScreens = [
    HomeScreen(),
    Container(),
    Container(),
    ProfileScreen(),
  ];
}
