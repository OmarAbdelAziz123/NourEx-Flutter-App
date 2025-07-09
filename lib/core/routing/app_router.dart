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
import 'package:nourex/features/cart/business_logic/cart_cubit.dart';
import 'package:nourex/features/cart/presentation/screens/cart_screen.dart';
import 'package:nourex/features/cart/presentation/screens/complete_pay_screenn.dart';
import 'package:nourex/features/categories/presentation/presentation/screens/categories_screen.dart';
import 'package:nourex/features/home/business_logic/home_cubit.dart';
import 'package:nourex/features/products/business_logic/products_cubit.dart';
import 'package:nourex/features/products/presentation/screens/best_seller_screen.dart';
import 'package:nourex/features/home/presentation/screens/home_screen.dart';
import 'package:nourex/features/main_layout/bloc/main_layout_cubit.dart';
import 'package:nourex/features/main_layout/presentation/main_layout.dart';
import 'package:nourex/features/my_orders/presentation/screens/my_orders_screen.dart';
import 'package:nourex/features/profile/business_logic/profile_cubit.dart';
import 'package:nourex/features/profile/presentation/screens/about_us_screen.dart';
import 'package:nourex/features/profile/presentation/screens/change_password_screen.dart';
import 'package:nourex/features/profile/presentation/screens/privacy_policy_screen.dart';
import 'package:nourex/features/profile/presentation/screens/profile_screen.dart';
import 'package:nourex/features/profile/presentation/screens/terms_and_conditions_screen.dart';
import 'package:nourex/features/search/business_logic/search_cubit.dart';
import 'package:nourex/features/search/presentation/filter_screen.dart';
import 'package:nourex/features/search/presentation/search_screen.dart';
import 'package:nourex/features/support/business_logic/support_cubit.dart';
import 'package:nourex/features/support/presentation/screens/support_screen.dart';
import 'package:nourex/features/wallet/business_logic/wallet_cubit.dart';
import 'package:nourex/features/wallet/presentation/screens/convert_points_to_balance_screen.dart';
import 'package:nourex/features/wallet/presentation/screens/wallet_screen.dart';
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
      final child =
          cubit != null
              ? BlocProvider<T>(create: (context) => cubit, child: screen)
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
        return transition(screen: const ChooseLoginOrRegisterScreen());
      case Routes.loginScreen:
        return transition(screen: const LoginScreen(), cubit: AuthCubit());
      case Routes.registerScreen:
        return transition(screen: const RegisterScreen(), cubit: AuthCubit());
      case Routes.verificationScreen:
        // final String emailAddress = settings.arguments as String;
        final Map<String, dynamic> data =
            settings.arguments as Map<String, dynamic>;

        return transition(
          screen: VerifyCodeScreen(data: data),
          cubit: AuthCubit()..startCountdown(),
        );
      case Routes.homeScreen:
        return transition(screen: const HomeScreen(), cubit: HomeCubit());
      case Routes.cartScreen:
        return transition(screen: const CartScreen(), cubit: CartCubit());
      case Routes.completePayScreen:
        return transition(screen: const CompletePayScreen(), cubit: CartCubit());
      case Routes.searchScreen:
        return transition(screen: const SearchScreen(), cubit: SearchCubit());
      case Routes.filterScreen:
        return transition(screen: const FilterScreen(), cubit: SearchCubit());
      case Routes.categoriesScreen:
        return transition(screen: const CategoriesScreen());
      case Routes.allBannersScreen:
        return transition(screen: const AllBannersScreen());
      case Routes.bestSellerScreen:
        return transition(
          screen: const BestSellerScreen(),
          cubit: ProductsCubit(),
        );
      case Routes.fillPasswordScreen:
        final Map<String, dynamic> data =
            settings.arguments as Map<String, dynamic>;

        return transition(
          screen: FillPasswordScreen(data: data),
          cubit: AuthCubit(),
        );
      case Routes.forgetPasswordScreen:
        return transition(screen: ForgetPasswordScreen(), cubit: AuthCubit());
      case Routes.profileScreen:
        return transition(screen: const ProfileScreen());
      case Routes.changePassword:
        return transition(
          screen: const ChangePasswordScreen(),
          cubit: ProfileCubit(),
        );
      case Routes.aboutUsScreen:
        return transition(
          screen: const AboutUsScreen(),
          cubit: ProfileCubit(),
        );
      case Routes.privacyPolicyScreen:
        return transition(
          screen: const PrivacyPolicyScreen(),
          cubit: ProfileCubit(),
        );
      case Routes.supportScreen:
        return transition(
          screen: const SupportScreen(),
          cubit: SupportCubit(),
        );
      case Routes.walletScreen:
        return transition(
          screen: const WalletScreen(),
          cubit: WalletCubit(),
        );
      case Routes.convertPointsToBalanceScreen:
        return transition(
          screen: const ConvertPointsToBalanceScreen(),
          cubit: WalletCubit(),
        );
      case Routes.termsAndConditionsScreen:
        return transition(
          screen: const TermsAndConditionsScreen(),
          cubit: ProfileCubit(),
        );
      case Routes.myOrdersScreen:
        return transition(screen: const MyOrdersScreen());
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
    BlocProvider(create: (context) => HomeCubit(), child: HomeScreen()),
    BlocProvider(create: (context) => CartCubit(), child: CartScreen()),
    MyOrdersScreen(),
    ProfileScreen(),
  ];
}
