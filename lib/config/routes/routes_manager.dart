// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../core/features/splash/presentation/screens/splash_screen.dart';
import '/config/routes/routes.dart';
import '/core/manager/strings_manager.dart';

import '/core/manager/color_manager.dart';

class RoutesManager {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    late Widget screen;

    switch (settings.name) {
      case Routes.splashScreen:
        screen = const SplashScreen();
        break;
      default:
        screen = _undefinedRouteScreen();
        break;
    }

    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
              child: child),
    );
  }

  static Widget _undefinedRouteScreen() {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: ColorsManager.redColor,
      body: Center(
        child: Text(StringsManager.undefinedRoute),
      ),
    );
  }
}
