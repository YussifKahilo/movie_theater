import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movie_theater/core/extensions/border_manager.dart';
import 'package:movie_theater/core/extensions/durations.dart';
import 'package:movie_theater/core/extensions/padding_manager.dart';
import 'package:movie_theater/core/extensions/responsive_manager.dart';

import '../../../../config/theme/themes_manager.dart';
import '../../../../core/manager/color_manager.dart';
import '../../../../core/manager/values_manager.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/loading.dart';

class LoginLoadingButton extends StatelessWidget {
  const LoginLoadingButton({
    Key? key,
    required this.isLoading,
    required this.onTap,
  }) : super(key: key);

  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: onTap,
      haveShadows: true,
      width: isLoading ? AppSize.s55.rh : ScreenUtil().screenWidth,
      height: AppSize.s55.rh,
      borderRadius: isLoading ? BorderValues.b45.borderAll : null,
      padding: PaddingValues.p15.pAll,
      duration: DurationValues.dm250.milliseconds,
      child: isLoading
          ? const CustomLoading(
              color: ColorsManager.whiteColor,
            )
          : Align(
              alignment: Alignment.center,
              child: CustomText('Login',
                  textStyle: ThemesManager.getBodySmallTextStyle(context),
                  color: ColorsManager.whiteColor,
                  fontWeight: FontWeight.bold),
            ),
    );
  }
}
