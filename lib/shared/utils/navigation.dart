import 'package:flutter/material.dart';

class NavigationHelper {
  static void navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static void navigateToReplacement(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static void navigateToAndRemoveUntil(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }

  static void navigateToAndRemoveUntilPredicate(
    BuildContext context,
    Widget page,
    RoutePredicate predicate,
  ) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      predicate,
    );
  }

  static void navigatePushReplacementNamed(BuildContext context, String page) {
    Navigator.pushReplacementNamed(context, page);
  }

  static void navigatePushNamed(BuildContext context, String page) {
    Navigator.pushNamed(context, page);
  }

  static void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  static void popUntil(BuildContext context, RoutePredicate predicate) {
    Navigator.popUntil(context, predicate);
  }

  static Future<bool> maybePop<T extends Object?>(
    BuildContext context, [
    T? result,
  ]) {
    return Navigator.maybePop(context, result);
  }

  static void pushNamedAndRemoveUntil(
    BuildContext context,
    String newRoute,
    RoutePredicate predicate,
  ) {
    Navigator.pushNamedAndRemoveUntil(context, newRoute, predicate);
  }

  static Future<T?> navigateToForResult<T>(BuildContext context, Widget page) {
    return Navigator.push<T>(context, MaterialPageRoute(builder: (_) => page));
  }
}
