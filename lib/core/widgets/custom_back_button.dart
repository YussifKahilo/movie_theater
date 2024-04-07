import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_theater/core/extensions/border_manager.dart';
import 'package:movie_theater/core/extensions/padding_manager.dart';

import '../manager/values_manager.dart';
import 'custom_container.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: ClipRRect(
            borderRadius: BorderValues.b15.borderAll,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
              child: const SizedBox(),
            ),
          ),
        ),
        CustomContainer(
          onTap: () => Navigator.pop(context),
          padding: PaddingValues.p10.pAll,
          isFilled: false,
          color: Theme.of(context).iconTheme.color,
          child: Stack(
            children: [
              Icon(
                Platform.isAndroid
                    ? Icons.arrow_back
                    : Icons.arrow_back_ios_new,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
