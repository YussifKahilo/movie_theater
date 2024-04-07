import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie_theater/core/extensions/animations_manager.dart';
import 'package:movie_theater/core/extensions/border_manager.dart';
import 'package:movie_theater/core/extensions/durations.dart';
import 'package:movie_theater/core/extensions/padding_manager.dart';
import 'package:movie_theater/core/extensions/responsive_manager.dart';
import 'package:movie_theater/core/extensions/spacer.dart';
import 'package:movie_theater/core/widgets/custom_container.dart';
import 'package:movie_theater/core/widgets/custom_password_field.dart';
import 'package:movie_theater/core/widgets/custom_svg.dart';
import '../../../../core/cubit/custom_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/widgets/loading.dart';
import '../../../../core/manager/color_manager.dart';
import '../../../../core/manager/fonts_manager.dart';
import '../../../../core/manager/values_manager.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/manager/assets_manager.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: (
          PaddingValues.pDefault.rw,
          PaddingValues.p65.rh + ScreenUtil().statusBarHeight,
          PaddingValues.pDefault.rw,
          PaddingValues.p65.rh + ScreenUtil().bottomBarHeight,
        )
            .pOnlyStartTopEndBottom,
        child: AnimationLimiter(
            child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomSvg(
                      AssetsManager.appIcon,
                      useColor: false,
                      size: AppSize.s150,
                    ),
                    Column(
                      children: [
                        CustomTextField(
                            controller: userNameController,
                            textInputType: TextInputType.name),
                        AppSize.s30.spaceH,
                        CustomPasswordField(controller: passwordController)
                      ],
                    ),
                    BlocProvider(
                      create: (context) => CustomCubit<bool>(false),
                      child: BlocBuilder<CustomCubit<bool>, bool>(
                        builder: (context, state) {
                          return CustomContainer(
                            onTap: () {
                              if (!state) {
                                CustomCubit.get<bool>(context)
                                    .changeState(!state);
                                Future.delayed(DurationValues.ds2.seconds, () {
                                  CustomCubit.get<bool>(context)
                                      .changeState(false);
                                  showDialog(
                                    context: context,
                                    builder: (context) => Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomContainer(
                                          haveShadows: true,
                                          padding: (
                                            PaddingValues.p20,
                                            PaddingValues.p50
                                          )
                                              .pSymmetricVH,
                                          borderRadius:
                                              BorderValues.b45.borderAll,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          child: Column(
                                            children: [
                                              CustomContainer(
                                                  shape: BoxShape.circle,
                                                  haveShadows: true,
                                                  child: Icon(
                                                    Icons.check,
                                                    size: AppSize.s150.rs,
                                                    color: ColorsManager
                                                        .whiteColor,
                                                  )),
                                              AppSize.s40.spaceH,
                                              const CustomText(
                                                  'You have logged in successfully !',
                                                  textAlign: TextAlign.center,
                                                  fontWeight: FontWeightManager
                                                      .semiBold)
                                            ],
                                          ),
                                        ).animateSlideFade(1,
                                            animationDirection:
                                                AnimationDirection.bTt),
                                      ],
                                    ),
                                  ).then((value) => Navigator.pop(context));
                                });
                              }
                            },
                            width: state
                                ? AppSize.s70.rw
                                : ScreenUtil().screenWidth,
                            borderRadius:
                                state ? BorderValues.b45.borderAll : null,
                            padding: PaddingValues.p15.pSymmetricVH,
                            duration: DurationValues.dm250.milliseconds,
                            child: state
                                ? const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomLoading(
                                        color: ColorsManager.whiteColor,
                                      ),
                                    ],
                                  )
                                : const CustomText('Login',
                                    fontSize: FontSize.f16,
                                    color: ColorsManager.whiteColor,
                                    fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }
}
