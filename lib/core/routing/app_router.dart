import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nourex/core/cache_helper/cache_keys.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/services/di/di.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/features/addresses/business_logic/addresses_cubit.dart';
import 'package:nourex/features/addresses/data/models/addresses_data_model.dart';
import 'package:nourex/features/addresses/presentation/screens/add_new_address_screen.dart';
import 'package:nourex/features/addresses/presentation/screens/address_details_screen.dart';
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
import 'package:nourex/features/categories/business_logic/categories_cubit.dart';
import 'package:nourex/features/categories/presentation/presentation/screens/categories_screen.dart';
import 'package:nourex/features/error/un_authorized_screen.dart';
import 'package:nourex/features/home/business_logic/home_cubit.dart';
import 'package:nourex/features/my_orders/business_logic/my_orders_cubit.dart';
import 'package:nourex/features/my_orders/data/models/my_orders_data_model.dart';
import 'package:nourex/features/my_orders/presentation/screens/returned_order_screen.dart';
import 'package:nourex/features/my_orders/presentation/screens/order_details_screen.dart';
import 'package:nourex/features/my_orders/presentation/screens/product_status_screen.dart';
import 'package:nourex/features/products/business_logic/products_cubit.dart';
import 'package:nourex/features/products/data/models/product_details_model.dart';
import 'package:nourex/features/products/presentation/screens/best_offers_screen.dart';
import 'package:nourex/features/products/presentation/screens/best_seller_screen.dart';
import 'package:nourex/features/home/presentation/screens/home_screen.dart';
import 'package:nourex/features/main_layout/bloc/main_layout_cubit.dart';
import 'package:nourex/features/main_layout/presentation/main_layout.dart';
import 'package:nourex/features/my_orders/presentation/screens/my_orders_screen.dart';
import 'package:nourex/features/products/presentation/screens/product_details_screen.dart';
import 'package:nourex/features/products/presentation/screens/product_reviews_screen.dart';
import 'package:nourex/features/products/presentation/screens/products_by_category_screen.dart';
import 'package:nourex/features/profile/business_logic/profile_cubit.dart';
import 'package:nourex/features/profile/data/models/profile/profile_data_model.dart';
import 'package:nourex/features/profile/data/models/returned_orders/returned_orders_data_model.dart';
import 'package:nourex/features/profile/presentation/screens/about_us_screen.dart';
import 'package:nourex/features/profile/presentation/screens/change_password_screen.dart';
import 'package:nourex/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:nourex/features/profile/presentation/screens/my_reviews_screen.dart';
import 'package:nourex/features/profile/presentation/screens/privacy_policy_screen.dart';
import 'package:nourex/features/profile/presentation/screens/profile_screen.dart';
import 'package:nourex/features/profile/presentation/screens/returned_orders_screen.dart';
import 'package:nourex/features/profile/presentation/screens/terms_and_conditions_screen.dart';
import 'package:nourex/features/search/business_logic/search_cubit.dart';
import 'package:nourex/features/search/presentation/filter_screen.dart';
import 'package:nourex/features/search/presentation/search_screen.dart';
import 'package:nourex/features/splash/business_logic/splash_cubit.dart';
import 'package:nourex/features/splash/presentation/screens/splash_screen.dart';
import 'package:nourex/features/support/business_logic/support_cubit.dart';
import 'package:nourex/features/support/presentation/screens/contact_support_screen.dart';
import 'package:nourex/features/support/presentation/screens/support_details_screen.dart';
import 'package:nourex/features/support/presentation/screens/support_screen.dart';
import 'package:nourex/features/wallet/business_logic/wallet_cubit.dart';
import 'package:nourex/features/wallet/presentation/screens/convert_points_to_balance_screen.dart';
import 'package:nourex/features/wallet/presentation/screens/wallet_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../features/addresses/presentation/screens/addresses_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    // Enhanced transition function with different animation types
    PageTransition transition<T extends Cubit<Object>>({
      required Widget screen,
      T? cubit,
      Object? arguments,
      PageTransitionType type = PageTransitionType.fade,
      Duration duration = const Duration(milliseconds: 300),
      Alignment alignment = Alignment.center,
      Curve curve = Curves.easeInOut,
      bool isIos = false,
    }) {
      final child = cubit != null
          ? BlocProvider<T>(create: (context) => cubit, child: screen)
          : screen;

      return PageTransition(
        child: child,
        type: type,
        duration: duration,
        alignment: alignment,
        settings: settings,
        curve: curve,
        isIos: isIos,
      );
    }

    // Custom slide transition with different directions
    PageTransition slideTransition<T extends Cubit<Object>>({
      required Widget screen,
      T? cubit,
      required SlideDirection direction,
      Duration duration = const Duration(milliseconds: 400),
    }) {
      final child = cubit != null
          ? BlocProvider<T>(create: (context) => cubit, child: screen)
          : screen;

      PageTransitionType type;
      switch (direction) {
        case SlideDirection.up:
          type = PageTransitionType.bottomToTop;
          break;
        case SlideDirection.down:
          type = PageTransitionType.topToBottom;
          break;
        case SlideDirection.left:
          type = PageTransitionType.rightToLeft;
          break;
        case SlideDirection.right:
          type = PageTransitionType.leftToRight;
          break;
      }

      return PageTransition(
        child: child,
        type: type,
        duration: duration,
        settings: settings,
        curve: Curves.easeOutCubic,
      );
    }

    // Scale transition with custom scaling
    PageTransition scaleTransition<T extends Cubit<Object>>({
      required Widget screen,
      T? cubit,
      Duration duration = const Duration(milliseconds: 400),
      Alignment alignment = Alignment.center,
    }) {
      final child = cubit != null
          ? BlocProvider<T>(create: (context) => cubit, child: screen)
          : screen;

      return PageTransition(
        child: child,
        type: PageTransitionType.scale,
        duration: duration,
        alignment: alignment,
        settings: settings,
        curve: Curves.elasticOut,
      );
    }

    // Rotate transition
    PageTransition rotateTransition<T extends Cubit<Object>>({
      required Widget screen,
      T? cubit,
      Duration duration = const Duration(milliseconds: 500),
    }) {
      final child = cubit != null
          ? BlocProvider<T>(create: (context) => cubit, child: screen)
          : screen;

      return PageTransition(
        child: child,
        type: PageTransitionType.rotate,
        duration: duration,
        settings: settings,
        curve: Curves.easeInOutBack,
      );
    }

    switch (settings.name) {
      // Splash screen with fade animation
      case Routes.splashScreen:
        return transition(
          screen: const SplashScreen(),
          cubit: SplashCubit(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 800),
        );

      // Auth screens with slide animations
      case Routes.chooseLoginOrRegisterScreen:
        return slideTransition(
          screen: const ChooseLoginOrRegisterScreen(),
          direction: SlideDirection.up,
        );

      case Routes.loginScreen:
        return slideTransition(
          screen: const LoginScreen(),
          cubit: AuthCubit(getIt()),
          direction: SlideDirection.right,
        );

      case Routes.registerScreen:
        return slideTransition(
          screen: const RegisterScreen(),
          cubit: AuthCubit(getIt()),
          direction: SlideDirection.left,
        );

      case Routes.verificationScreen:
        final Map<String, dynamic> data =
            settings.arguments as Map<String, dynamic>;
        return transition(
          screen: VerifyCodeScreen(data: data),
          cubit: AuthCubit(getIt())..startCountdown(),
          type: PageTransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 400),
        );

      // Main app screens with different animations
      case Routes.homeScreen:
        return transition(
          screen: const HomeScreen(),
          cubit: HomeCubit(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 300),
        );

      case Routes.cartScreen:
        return slideTransition(
          screen: const CartScreen(),
          cubit: CartCubit(getIt())..getCart(),
          direction: SlideDirection.up,
        );

      case Routes.completePayScreen:
        final int totalPrice = settings.arguments as int;

        return scaleTransition(
          screen: CompletePayScreen(totalPrice: totalPrice),
          cubit: CartCubit(getIt())
            ..getCart()
            ..getMainAddress(),
          alignment: Alignment.center,
        );

      case Routes.searchScreen:
        return transition(
          screen: const SearchScreen(),
          cubit: SearchCubit(),
          type: PageTransitionType.topToBottom,
          duration: const Duration(milliseconds: 300),
        );

      case Routes.filterScreen:
        return slideTransition(
          screen: const FilterScreen(),
          cubit: SearchCubit(),
          direction: SlideDirection.left,
        );

      case Routes.categoriesScreen:
        return transition(
          screen: const CategoriesScreen(),
          cubit: CategoriesCubit(getIt())..getInitialCategories(),
          type: PageTransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 350),
        );

      case Routes.productReviewsScreen:
        final productDetailsModel = settings.arguments as Result;

        return transition(
          screen:
              ProductReviewsScreen(productDetailsModel: productDetailsModel),
          cubit: ProductsCubit(getIt())
            ..getInitialProductReviews(
              productId: productDetailsModel.sId!,
            ),
          type: PageTransitionType.leftToRightWithFade,
          duration: const Duration(milliseconds: 350),
        );

      case Routes.allBannersScreen:
        return transition(
          screen: const AllBannersScreen(),
          type: PageTransitionType.leftToRightWithFade,
          duration: const Duration(milliseconds: 350),
        );

      case Routes.productsByCategoryScreen:
        // final categoryId = settings.arguments as String;
        final Map<String, dynamic> data =
            settings.arguments as Map<String, dynamic>;

        return transition(
          screen: ProductsByCategoryScreen(data: data),
          cubit: ProductsCubit(getIt())
            ..getInitialProductsByCategory(categoryId: data['categoryId']),
          type: PageTransitionType.leftToRightWithFade,
          duration: const Duration(milliseconds: 350),
        );

      case Routes.bestSellerScreen:
        return slideTransition(
          screen: const BestSellerScreen(),
          cubit: ProductsCubit(getIt())..getInitialProducts(),
          direction: SlideDirection.up,
        );

      case Routes.bestOffersScreen:
        return slideTransition(
          screen: const BestOffersScreen(),
          cubit: ProductsCubit(getIt())..getInitialProducts(),
          direction: SlideDirection.up,
        );

      case Routes.productDetailsScreen:
        final productId = settings.arguments as String;

        return slideTransition(
          screen: ProductDetailsScreen(
            productId: productId,
          ),
          cubit: ProductsCubit(getIt())
            ..getProductById(productId: productId)
            ..getInitialProductReviews(productId: productId),
          direction: SlideDirection.up,
        );

      // Password and auth related screens
      case Routes.fillPasswordScreen:
        final Map<String, dynamic> data =
            settings.arguments as Map<String, dynamic>;
        return transition(
          screen: FillPasswordScreen(data: data),
          cubit: AuthCubit(getIt()),
          type: PageTransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 400),
        );

      case Routes.forgetPasswordScreen:
        return slideTransition(
          screen: ForgetPasswordScreen(),
          cubit: AuthCubit(getIt()),
          direction: SlideDirection.up,
        );

      // Profile related screens
      case Routes.profileScreen:
        return transition(
          cubit: ProfileCubit(getIt())..getProfile(),
          screen: const ProfileScreen(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 250),
        );

      case Routes.changePassword:
        return slideTransition(
          screen: const ChangePasswordScreen(),
          cubit: ProfileCubit(getIt()),
          direction: SlideDirection.right,
        );

      case Routes.editProfileScreen:
        final profileData = settings.arguments as ProfileUserModel;

        return slideTransition(
          screen: EditProfileScreen(profileData: profileData),
          cubit: ProfileCubit(getIt())..getProfile(),
          direction: SlideDirection.up,
        );

      case Routes.myReviewsScreen:
        return slideTransition(
          screen: const MyReviewsScreen(),
          cubit: ProfileCubit(getIt())..getInitialMyReviews(),
          direction: SlideDirection.up,
        );

      // Info screens with consistent animations
      case Routes.aboutUsScreen:
        return transition(
          screen: const AboutUsScreen(),
          cubit: ProfileCubit(getIt()),
          type: PageTransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 350),
        );

      // Info screens with consistent animations
      case Routes.returnedOrdersScreen:
        return transition(
          screen: const ReturnedOrdersScreen(),
          cubit: ProfileCubit(getIt())..getInitialMyReturnedOrders(status: 'Return pending'),
          type: PageTransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 350),
        );

      // Info screens with consistent animations
      case Routes.returnedOrderDetailsScreen:
        final Map<String, dynamic> returnedData = settings.arguments as Map<String, dynamic>;
        // final ReturnedOrder returnedOrder = settings.arguments as ReturnedOrder;

        return transition(
          screen: ReturnedOrderDetailsScreen(returnedData: returnedData),
          // screen: ReturnedOrderDetailsScreen(returnedOrder: returnedOrder),
          cubit: ProfileCubit(getIt()),
          type: PageTransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 350),
        );

      case Routes.privacyPolicyScreen:
        return transition(
          screen: const PrivacyPolicyScreen(),
          cubit: ProfileCubit(getIt()),
          type: PageTransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 350),
        );

      case Routes.termsAndConditionsScreen:
        return transition(
          screen: const TermsAndConditionsScreen(),
          cubit: ProfileCubit(getIt()),
          type: PageTransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 350),
        );

      // Support screens
      case Routes.supportScreen:
        return slideTransition(
          screen: const SupportScreen(),
          cubit: SupportCubit(),
          direction: SlideDirection.up,
        );

      case Routes.supportDetailsScreenRoute:
        return transition(
          screen: const SupportDetailsScreen(),
          cubit: SupportCubit(),
          type: PageTransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 300),
        );

      case Routes.contactSupportScreenRoute:
        return slideTransition(
          screen: const ContactSupportScreen(),
          cubit: SupportCubit(),
          direction: SlideDirection.up,
        );

      // Wallet screens
      case Routes.walletScreen:
        return scaleTransition(
          screen: const WalletScreen(),
          cubit: WalletCubit(getIt())..getWalletHistory(type: 'balance'),
          alignment: Alignment.center,
        );

      case Routes.convertPointsToBalanceScreen:
        return slideTransition(
          screen: const ConvertPointsToBalanceScreen(),
          cubit: WalletCubit(getIt()),
          direction: SlideDirection.up,
        );

      // Orders screens
      case Routes.myOrdersScreen:
        return slideTransition(
          screen: const MyOrdersScreen(),
          cubit: MyOrdersCubit(getIt()),
          direction: SlideDirection.right,
        );

      case Routes.orderDetailsScreen:
        final MyOrder ordersList = settings.arguments as MyOrder;

        return transition(
          screen: OrderDetailsScreen(ordersList: ordersList),
          cubit: MyOrdersCubit(getIt()),
          type: PageTransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 350),
        );

      case Routes.productStatusScreen:
        final Map<String, dynamic > data = settings.arguments as Map<String, dynamic>;
        // final MyOrderProduct myOrderProduct = settings.arguments as MyOrderProduct;

        return transition(
          screen: ProductStatusScreen(data: data),
          cubit: MyOrdersCubit(getIt()),
          type: PageTransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 350),
        );

      case Routes.cancelOrderScreen:
        final Map<String, dynamic> orderData =
            settings.arguments as Map<String, dynamic>;

        return slideTransition(
          screen: ReturnedOrderScreen(
            orderData: orderData,
          ),
          cubit: MyOrdersCubit(getIt()),
          direction: SlideDirection.up,
        );

      // Address screens
      case Routes.addressesScreen:
        return slideTransition(
          screen: const AddressesScreen(),
          cubit: AddressesCubit(getIt())..getInitialAddresses(),
          direction: SlideDirection.right,
        );
      case Routes.addressDetailsScreen:
        final addressModel = settings.arguments as AddressModel;

        return slideTransition(
          screen: AddressDetailsScreen(addressModel: addressModel),
          cubit: AddressesCubit(getIt()),
          direction: SlideDirection.right,
        );

      case Routes.addNewAddressScreen:
        return slideTransition(
          screen: const AddNewAddressScreen(),
          cubit: AddressesCubit(getIt()),
          direction: SlideDirection.up,
        );

      // Main layout with fade
      case Routes.mainLayoutScreen:
        final index = settings.arguments as int? ?? 0;
        return transition(
          screen: MainLayout(index: index),
          cubit: MainLayoutCubit(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 400),
        );
    }
    return null;
  }

  List<Widget> userScreens = [
    BlocProvider(create: (context) => HomeCubit(), child: HomeScreen()),
    BlocProvider(
        create: (context) => CartCubit(getIt())..getCart(),
        child: CartScreen()),
    BlocProvider(
        create: (context) => MyOrdersCubit(getIt()), child: MyOrdersScreen()),
    BlocProvider(
      create: (context) => ProfileCubit(getIt())..getProfile(),
      child: ProfileScreen(),
    ),
  ];
}

// Enum for slide directions
enum SlideDirection { up, down, left, right }

// Custom page route with advanced animations
class CustomPageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;
  final AxisDirection direction;
  final Duration duration;

  CustomPageRoute({
    required this.child,
    this.direction = AxisDirection.right,
    this.duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) : super(
          settings: settings,
          transitionDuration: duration,
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    switch (direction) {
      case AxisDirection.up:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        );
      case AxisDirection.down:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        );
      case AxisDirection.left:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        );
      case AxisDirection.right:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        );
    }
  }
}

// Advanced custom animations
class AdvancedAnimations {
  static Route<T> createSlideRoute<T>({
    required Widget page,
    required RouteSettings settings,
    SlideDirection direction = SlideDirection.right,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    Offset begin;
    switch (direction) {
      case SlideDirection.up:
        begin = const Offset(0, 1);
        break;
      case SlideDirection.down:
        begin = const Offset(0, -1);
        break;
      case SlideDirection.left:
        begin = const Offset(1, 0);
        break;
      case SlideDirection.right:
        begin = const Offset(-1, 0);
        break;
    }

    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: begin,
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: curve)),
          child: child,
        );
      },
    );
  }

  static Route<T> createFadeRoute<T>({
    required Widget page,
    required RouteSettings settings,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: curve),
          child: child,
        );
      },
    );
  }

  static Route<T> createScaleRoute<T>({
    required Widget page,
    required RouteSettings settings,
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.elasticOut,
    Alignment alignment = Alignment.center,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          alignment: alignment,
          scale: CurvedAnimation(parent: animation, curve: curve),
          child: child,
        );
      },
    );
  }

  static Route<T> createRotationRoute<T>({
    required Widget page,
    required RouteSettings settings,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOut,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return RotationTransition(
          turns: CurvedAnimation(parent: animation, curve: curve),
          child: child,
        );
      },
    );
  }
}

// class AppRouter {
//   Route? generateRoute(RouteSettings settings) {
//     PageTransition transition<T extends Cubit<Object>>({
//       required Widget screen,
//       T? cubit,
//       Object? arguments,
//       PageTransitionType type = PageTransitionType.fade,
//       Duration duration = const Duration(milliseconds: 200),
//       Alignment alignment = Alignment.center,
//     }) {
//       final child =
//           cubit != null
//               ? BlocProvider<T>(create: (context) => cubit, child: screen)
//               : screen;
//
//       return PageTransition(
//         child: child,
//         type: type,
//         duration: duration,
//         alignment: alignment,
//         settings: settings,
//       );
//     }
//
//     switch (settings.name) {
//       case Routes.splashScreen:
//         return transition(screen: const SplashScreen(), cubit: SplashCubit());
//       case Routes.chooseLoginOrRegisterScreen:
//         return transition(screen: const ChooseLoginOrRegisterScreen());
//       case Routes.loginScreen:
//         return transition(screen: const LoginScreen(), cubit: AuthCubit(getIt()));
//       case Routes.registerScreen:
//         return transition(screen: const RegisterScreen(), cubit: AuthCubit(getIt()));
//       case Routes.verificationScreen:
//         // final String emailAddress = settings.arguments as String;
//         final Map<String, dynamic> data =
//             settings.arguments as Map<String, dynamic>;
//
//         return transition(
//           screen: VerifyCodeScreen(data: data),
//           cubit: AuthCubit(getIt())..startCountdown(),
//         );
//       case Routes.homeScreen:
//         return transition(screen: const HomeScreen(), cubit: HomeCubit());
//       case Routes.cartScreen:
//         return transition(screen: const CartScreen(), cubit: CartCubit());
//       case Routes.completePayScreen:
//         return transition(
//           screen: const CompletePayScreen(),
//           cubit: CartCubit(),
//         );
//       case Routes.searchScreen:
//         return transition(screen: const SearchScreen(), cubit: SearchCubit());
//       case Routes.filterScreen:
//         return transition(screen: const FilterScreen(), cubit: SearchCubit());
//       case Routes.categoriesScreen:
//         return transition(screen: const CategoriesScreen());
//       case Routes.allBannersScreen:
//         return transition(screen: const AllBannersScreen());
//       case Routes.bestSellerScreen:
//         return transition(
//           screen: const BestSellerScreen(),
//           cubit: ProductsCubit(),
//         );
//       case Routes.productDetailsScreen:
//         return transition(
//           screen: const ProductDetailsScreen(),
//           cubit: ProductsCubit(),
//         );
//       case Routes.fillPasswordScreen:
//         final Map<String, dynamic> data =
//             settings.arguments as Map<String, dynamic>;
//
//         return transition(
//           screen: FillPasswordScreen(data: data),
//           cubit: AuthCubit(getIt()),
//         );
//       case Routes.forgetPasswordScreen:
//         return transition(screen: ForgetPasswordScreen(), cubit: AuthCubit(getIt()));
//       case Routes.profileScreen:
//         return transition(screen: const ProfileScreen());
//       case Routes.changePassword:
//         return transition(
//           screen: const ChangePasswordScreen(),
//           cubit: ProfileCubit(getIt()),
//         );
//       case Routes.aboutUsScreen:
//         return transition(screen: const AboutUsScreen(), cubit: ProfileCubit(getIt()));
//       case Routes.privacyPolicyScreen:
//         return transition(
//           screen: const PrivacyPolicyScreen(),
//           cubit: ProfileCubit(getIt()),
//         );
//       case Routes.supportScreen:
//         return transition(screen: const SupportScreen(), cubit: SupportCubit());
//       case Routes.walletScreen:
//         return transition(screen: const WalletScreen(), cubit: WalletCubit());
//       case Routes.convertPointsToBalanceScreen:
//         return transition(
//           screen: const ConvertPointsToBalanceScreen(),
//           cubit: WalletCubit(),
//         );
//       case Routes.termsAndConditionsScreen:
//         return transition(
//           screen: const TermsAndConditionsScreen(),
//           cubit: ProfileCubit(getIt()),
//         );
//       case Routes.myOrdersScreen:
//         return transition(
//           screen: const MyOrdersScreen(),
//           cubit: MyOrdersCubit(),
//         );
//       case Routes.orderDetailsScreen:
//         return transition(
//           screen: const OrderDetailsScreen(),
//           cubit: MyOrdersCubit(),
//         );
//       case Routes.cancelOrderScreen:
//         return transition(screen: CancelOrderScreen(), cubit: MyOrdersCubit());
//       case Routes.supportDetailsScreenRoute:
//         return transition(
//           screen: const SupportDetailsScreen(),
//           cubit: SupportCubit(),
//         );
//
//       case Routes.contactSupportScreenRoute:
//         return transition(
//           screen: const ContactSupportScreen(),
//           cubit: SupportCubit(),
//         );
//
//       case Routes.editProfileScreen:
//         return transition(
//           screen: const EditProfileScreen(),
//           cubit: ProfileCubit(getIt()),
//         );
//
//       case Routes.addressesScreen:
//         return transition(
//           screen: const AddressesScreen(),
//           cubit: AddressesCubit(),
//         );
//
//       case Routes.addNewAddressScreen:
//         return transition(
//           screen: const AddNewAddressScreen(),
//           cubit: AddressesCubit(),
//         );
//
//       case Routes.mainLayoutScreen:
//         final index = settings.arguments as int? ?? 0;
//
//         return transition(
//           screen: MainLayout(index: index),
//           cubit: MainLayoutCubit(),
//         );
//     }
//     return null;
//   }
//
//   List<Widget> userScreens = [
//     BlocProvider(create: (context) => HomeCubit(), child: HomeScreen()),
//     BlocProvider(create: (context) => CartCubit(), child: CartScreen()),
//     MyOrdersScreen(),
//     BlocProvider(create: (context) => ProfileCubit(getIt()), child: ProfileScreen()),
//   ];
// }
