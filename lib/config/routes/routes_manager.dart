// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movie_theater/features/auth/presentation/screens/login_screen.dart';
import 'package:movie_theater/features/layout/presentation/screen/layout_screen.dart';
import 'package:movie_theater/features/movies/domain/entities/movie.dart';
import 'package:movie_theater/features/movies/presentation/screens/movies_list_screen.dart';
import '../../core/features/splash/presentation/screens/splash_screen.dart';
import '../../features/movies/presentation/screens/movie_details_screen.dart';
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
      case Routes.layoutScreen:
        screen = LayoutScreen();
        break;
      case Routes.loginScreen:
        screen = const LoginScreen();
        break;
      case Routes.movieDetailsScreen:
        screen = MovieDetailsScreen(
          movie: (settings.arguments as (Movie, bool)).$1,
          cacheData: (settings.arguments as (Movie, bool)).$2,
        );
        break;
      case Routes.moviesListScreen:
        screen = MoviesListScreen(
          movieSection: settings.arguments as MovieSection,
        );
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
