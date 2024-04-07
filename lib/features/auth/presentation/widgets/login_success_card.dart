import 'package:flutter/material.dart';
import 'package:movie_theater/core/extensions/border_manager.dart';
import 'package:movie_theater/core/extensions/padding_manager.dart';
import 'package:movie_theater/core/extensions/responsive_manager.dart';
import 'package:movie_theater/core/extensions/spacer.dart';

import '../../../../core/extensions/animations_manager.dart';
import '../../../../core/manager/color_manager.dart';
import '../../../../core/manager/fonts_manager.dart';
import '../../../../core/manager/values_manager.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../../../core/widgets/custom_text.dart';

class LoginSuccessCard extends StatelessWidget {
  const LoginSuccessCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomContainer(
          haveShadows: true,
          shadowColor: ColorsManager.greyColor,
          padding: (PaddingValues.p20, PaddingValues.p50).pSymmetricVH,
          borderRadius: BorderValues.b45.borderAll,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              CustomContainer(
                  shape: BoxShape.circle,
                  haveShadows: true,
                  child: Icon(
                    Icons.check,
                    size: AppSize.s150.rs,
                    color: ColorsManager.whiteColor,
                  )),
              AppSize.s40.spaceH,
              const CustomText('You have logged in successfully !',
                  textAlign: TextAlign.center,
                  fontWeight: FontWeightManager.semiBold)
            ],
          ),
        ).animateSlideFade(1, animationDirection: AnimationDirection.bTt),
      ],
    );
  }
}
