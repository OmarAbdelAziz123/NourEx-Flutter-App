import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/features/auth/business_logic/auth_cubit.dart';
import 'package:nourex/features/auth/presentation/screens/choose_login_or_register_screen.dart';
import 'package:nourex/features/auth/presentation/screens/fill_password_screen.dart';
import 'package:nourex/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:nourex/features/auth/presentation/screens/login_screen.dart';
import 'package:nourex/features/auth/presentation/screens/register_screen.dart';
import 'package:nourex/features/auth/presentation/screens/verify_code_screen.dart';
import 'package:nourex/features/banners/presentation/screens/all_banners_screen.dart';
import 'package:nourex/features/categories/presentation/presentation/screens/categories_screen.dart';
import 'package:nourex/features/products/business_logic/products_cubit.dart';
import 'package:nourex/features/products/presentation/screens/best_seller_screen.dart';
import 'package:nourex/features/home/presentation/screens/home_screen.dart';
import 'package:nourex/features/main_layout/bloc/main_layout_cubit.dart';
import 'package:nourex/features/main_layout/presentation/main_layout.dart';
import 'package:nourex/features/my_orders/presentation/screens/my_orders_screen.dart';
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
      case Routes.chooseLoginOrRegisterScreen:
        return transition(
          screen: const ChooseLoginOrRegisterScreen(),
        );
      case Routes.loginScreen:
        return transition(
          screen: const LoginScreen(),
          cubit: AuthCubit(),
        );
      case Routes.registerScreen:
        return transition(
          screen: const RegisterScreen(),
          cubit: AuthCubit(),
        );
      case Routes.verificationScreen:
        // final String emailAddress = settings.arguments as String;
      final Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;

        return transition(
          screen: VerifyCodeScreen(data: data),
          cubit: AuthCubit()..startCountdown(),
        );
      case Routes.homeScreen:
        return transition(
          screen: const HomeScreen(),
        );
      case Routes.categoriesScreen:
        return transition(
          screen: const CategoriesScreen(),
        );
      case Routes.allBannersScreen:
        return transition(
          screen: const AllBannersScreen(),
        );
      case Routes.bestSellerScreen:
        return transition(
          screen: const BestSellerScreen(),
          cubit: ProductsCubit(),
        );
      case Routes.fillPasswordScreen:
        final Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;

        return transition(
          screen: FillPasswordScreen(data: data),
          cubit: AuthCubit(),
        );
      case Routes.forgetPasswordScreen:
        return transition(
          screen: ForgetPasswordScreen(),
          cubit: AuthCubit(),
        );
      case Routes.profileScreen:
        return transition(
          screen: const ProfileScreen(),
        );
      case Routes.myOrdersScreen:
        return transition(
          screen: const MyOrdersScreen(),
        );
      case Routes.mainLayoutScreen:
        final index = settings.arguments as int? ?? 0;

        return transition(
          screen: MainLayout(index: index),
          cubit: MainLayoutCubit(),
        );
    }
    return null;
  }

  List<Widget> userScreens = [
    HomeScreen(),
    Container(),
    MyOrdersScreen(),
    ProfileScreen(),
  ];
}
