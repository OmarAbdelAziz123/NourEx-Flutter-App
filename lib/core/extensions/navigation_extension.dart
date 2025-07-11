import 'package:flutter/material.dart';

import '../routing/route_builder_map.dart';
//
// extension Navigation on BuildContext {
//   Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
//     return Navigator.of(this).pushNamed(routeName, arguments: arguments);
//   }
//
//   Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
//     return Navigator.of(this)
//         .pushReplacementNamed(routeName, arguments: arguments);
//   }
//
//   Future<dynamic> pushNamedAndRemoveUntil(
//       String routeName,
//       {Object? arguments, }) {
//     return Navigator.of(this).pushNamedAndRemoveUntil(
//         routeName, (route) => false,
//         arguments: arguments);
//   }
//
//   void pop() => Navigator.of(this).pop();
// }
extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(
      String routeName, {
        Object? arguments,
      }) {
    return Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
          (route) => false,
      arguments: arguments,
    );
  }

  Future<T?> pushWithSwipe<T>(Widget page) {
    return Navigator.of(this).push<T>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Swipe-back named push using onGenerateRoute
  Future<T?> pushNamedWithSwipe<T>(String routeName, {Object? arguments}) {
    final builder = routeBuilderMap[routeName];
    if (builder == null) {
      throw Exception("Route not found: $routeName");
    }

    return Navigator.of(this).push<T>(
      MaterialPageRoute(
        builder: builder,
        settings: RouteSettings(name: routeName, arguments: arguments),
      ),
    );
  }

  void pop() => Navigator.of(this).pop();
}
