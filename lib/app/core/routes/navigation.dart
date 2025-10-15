
import 'package:flutter/material.dart';

final navigationKey = GlobalKey<NavigatorState>();

class CustomNavigator {
  CustomNavigator._singleTone();

  static final CustomNavigator _instance = CustomNavigator._singleTone();

  static CustomNavigator get instance => _instance;

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) async {
    return Navigator.pushNamed(
      navigationKey.currentContext!,
      routeName,
      arguments: arguments,
    );
  }

  void pop<T>({Object? arguments}) async {
    return Navigator.pop(
      navigationKey.currentContext!,
    );
  }

  // Future<T?> pushWithBottom<T>(
  //     {required Widget screen, required BuildContext context}) async {
  //   return PersistentNavBarNavigator.pushNewScreen(
  //     context,
  //     screen: screen,
  //     withNavBar: true,
  //     pageTransitionAnimation: PageTransitionAnimation.fade,
  //   );
  // }

  void pushNamedAndRemoveUntil(
      String routeName, bool Function(Route<dynamic> route) callback,
      {Object? arguments}) {
    Navigator.pushNamedAndRemoveUntil(
        navigationKey.currentContext!, routeName, callback,
        arguments: arguments);
  }

  void pushReplacementNamed(String routeName, {Object? argument}) {
    Navigator.pushReplacementNamed(navigationKey.currentContext!, routeName,
        arguments: argument);
  }
}
