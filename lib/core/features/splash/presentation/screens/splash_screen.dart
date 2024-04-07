import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_theater/config/routes/routes.dart';
import 'package:movie_theater/core/extensions/durations.dart';
import 'package:movie_theater/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:movie_theater/features/favorites/presentation/cubit/favorites_cubit.dart';
import '../../../../manager/assets_manager.dart';
import '/core/manager/values_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  void _navigateToNextScreen() =>
      Navigator.pushReplacementNamed(context, Routes.layoutScreen);

  void _startDelay() {
    _timer = Timer(const Duration(seconds: Values.splashDurationSeconds), () {
      if (AuthCubit.get(context).state is! GetUserLoadingState) {
        _navigateToNextScreen();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is GetUserFailedState || current is GetUserSuccessState,
      listener: (context, state) {
        if (state is GetUserSuccessState) {
          FavoritesCubit.get(context).getFavorites(1);
          if (_timer != null && !_timer!.isActive) {
            _navigateToNextScreen();
          }
        } else if (state is GetUserFailedState) {
          if (_timer != null && !_timer!.isActive) {
            _navigateToNextScreen();
          }
        }
      },
      child: Scaffold(
        body: Center(
          child: AnimationLimiter(
            child: AnimationConfiguration.staggeredList(
              position: 0,
              child: FadeInAnimation(
                curve: Curves.bounceInOut,
                duration: Values.splashDurationSeconds.seconds,
                child: SvgPicture.asset(
                  AssetsManager.appIcon,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
