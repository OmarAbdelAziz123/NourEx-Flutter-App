import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/features/auth/business_logic/auth_cubit.dart';
import 'package:nourex/features/auth/presentation/screens/choose_login_or_register_screen.dart';
import 'package:nourex/features/auth/presentation/screens/login_screen.dart';
import 'package:nourex/features/auth/presentation/screens/register_screen.dart';
import 'package:nourex/features/banners/presentation/screens/all_banners_screen.dart';
import 'package:nourex/features/cart/business_logic/cart_cubit.dart';
import 'package:nourex/features/cart/presentation/screens/cart_screen.dart';
import 'package:nourex/features/cart/presentation/screens/complete_pay_screenn.dart';
import 'package:nourex/features/categories/presentation/presentation/screens/categories_screen.dart';
import 'package:nourex/features/home/business_logic/home_cubit.dart';
import 'package:nourex/features/home/presentation/screens/home_screen.dart';
import 'package:nourex/features/my_orders/presentation/screens/my_orders_screen.dart';
import 'package:nourex/features/my_orders/presentation/screens/order_details_screen.dart';
import 'package:nourex/features/products/business_logic/products_cubit.dart';
import 'package:nourex/features/products/presentation/screens/best_seller_screen.dart';
import 'package:nourex/features/profile/business_logic/profile_cubit.dart';
import 'package:nourex/features/profile/presentation/screens/about_us_screen.dart';
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

final Map<String, WidgetBuilder> routeBuilderMap = {
  // Routes.splashScreen: (_) => const SplashScreen(),
  Routes.chooseLoginOrRegisterScreen: (_) => const ChooseLoginOrRegisterScreen(),
  Routes.loginScreen: (_) => BlocProvider(create: (_) => AuthCubit(), child: const LoginScreen()),
  Routes.registerScreen: (_) => BlocProvider(create: (_) => AuthCubit(), child: const RegisterScreen()),
  Routes.homeScreen: (_) => BlocProvider(create: (_) => HomeCubit(), child: const HomeScreen()),
  Routes.cartScreen: (_) => BlocProvider(create: (_) => CartCubit(), child: const CartScreen()),
  Routes.completePayScreen: (_) => BlocProvider(create: (_) => CartCubit(), child: const CompletePayScreen()),
  Routes.searchScreen: (_) => BlocProvider(create: (_) => SearchCubit(), child: const SearchScreen()),
  Routes.filterScreen: (_) => BlocProvider(create: (_) => SearchCubit(), child: const FilterScreen()),
  Routes.categoriesScreen: (_) => const CategoriesScreen(),
  Routes.allBannersScreen: (_) => const AllBannersScreen(),
  Routes.bestSellerScreen: (_) => BlocProvider(create: (_) => ProductsCubit(), child: const BestSellerScreen()),
  Routes.profileScreen: (_) => const ProfileScreen(),
  Routes.aboutUsScreen: (_) => BlocProvider(create: (_) => ProfileCubit(), child: const AboutUsScreen()),
  Routes.privacyPolicyScreen: (_) => BlocProvider(create: (_) => ProfileCubit(), child: const PrivacyPolicyScreen()),
  Routes.supportScreen: (_) => BlocProvider(create: (_) => SupportCubit(), child: const SupportScreen()),
  Routes.walletScreen: (_) => BlocProvider(create: (_) => WalletCubit(), child: const WalletScreen()),
  Routes.convertPointsToBalanceScreen: (_) => BlocProvider(create: (_) => WalletCubit(), child: const ConvertPointsToBalanceScreen()),
  Routes.termsAndConditionsScreen: (_) => BlocProvider(create: (_) => ProfileCubit(), child: const TermsAndConditionsScreen()),
  Routes.myOrdersScreen: (_) => const MyOrdersScreen(),
  Routes.orderDetailsScreen: (_) => const OrderDetailsScreen(),
};
