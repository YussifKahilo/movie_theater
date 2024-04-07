import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movie_theater/core/extensions/border_manager.dart';
import '../manager/values_manager.dart';
import 'custom_container.dart';

class BlurredBackGround extends StatelessWidget {
  const BlurredBackGround({
    Key? key,
    required this.customImage,
  }) : super(key: key);

  final Widget customImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        customImage,
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          bottom: 0,
          child: CustomContainer(
            borderRadius: BorderRadius.zero,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).scaffoldBackgroundColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            child: const SizedBox(),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: ClipRRect(
            borderRadius: BorderValues.b15.borderAll,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: const SizedBox(),
            ),
          ),
        ),
      ],
    );
  }
}
