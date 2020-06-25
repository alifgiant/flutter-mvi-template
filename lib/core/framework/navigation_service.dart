import 'package:flutter/material.dart';

typedef NavigatorFactory = NavigationService Function();

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Future<dynamic> navigateTo(String routeName) {
  //   return navigatorKey.currentState.pushNamed(routeName);
  // }

  Future<T> navigateTo<T extends Object>(Widget screen) {
    return navigatorKey.currentState.push(
      MaterialPageRoute(builder: (ctx) => screen),
    );
  }

  void goBack<T extends Object>([T result]) {
    return navigatorKey.currentState.pop(result);
  }
}
