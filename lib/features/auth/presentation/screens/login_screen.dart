import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie_theater/core/extensions/animations_manager.dart';
import 'package:movie_theater/core/extensions/padding_manager.dart';
import 'package:movie_theater/core/extensions/responsive_manager.dart';
import 'package:movie_theater/core/extensions/spacer.dart';
import 'package:movie_theater/core/manager/strings_manager.dart';
import 'package:movie_theater/core/widgets/custom_back_button.dart';
import 'package:movie_theater/core/widgets/custom_password_field.dart';
import 'package:movie_theater/core/widgets/custom_snackbar.dart';
import 'package:movie_theater/core/widgets/custom_svg.dart';
import 'package:movie_theater/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:movie_theater/core/widgets/blurred_background.dart';
import 'package:movie_theater/features/auth/presentation/widgets/login_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/manager/values_manager.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/manager/assets_manager.dart';
import '../widgets/login_success_card.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Stack(
        children: [
          BlurredBackGround(
            customImage: CustomImage(
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight,
              imageAsset: AssetsManager.loginWallpaper,
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: AnimationLimiter(
                child: SizedBox(
              height: ScreenUtil().screenHeight,
              child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const CustomSvg(
                            AssetsManager.appIcon,
                            useColor: false,
                            size: AppSize.s150,
                          ).animateSlideFade(1,
                              animationDirection: AnimationDirection.tTb),
                          AppSize.s50.spaceH,
                          CustomTextField(
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return StringsManager
                                          .felidShouldNotBeEmpty;
                                    }
                                    return null;
                                  },
                                  hintText: 'Username',
                                  controller: userNameController,
                                  textInputType: TextInputType.name)
                              .animateSlideFade(2,
                                  animationDirection: AnimationDirection.lTr),
                          AppSize.s30.spaceH,
                          CustomPasswordField(
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return StringsManager.felidShouldNotBeEmpty;
                              }
                              return null;
                            },
                            controller: passwordController,
                            hintText: 'Password',
                          ).animateSlideFade(3,
                              animationDirection: AnimationDirection.rTl)
                        ],
                      ),
                      BlocConsumer<AuthCubit, AuthState>(
                        buildWhen: (previous, current) =>
                            current is GetUserSuccessState ||
                            current is GetUserFailedState ||
                            current is LoginFailedState ||
                            current is LoginLoadingState,
                        listener: (context, state) {
                          if (state is GetUserSuccessState) {
                            showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const LoginSuccessCard())
                                .then((value) => Navigator.pop(context, true));
                          } else if (state is LoginFailedState) {
                            showSnackBar(
                                context: context, content: state.message);
                          } else if (state is GetUserFailedState) {
                            showSnackBar(
                                context: context, content: state.message);
                          }
                        },
                        builder: (context, state) {
                          bool isLoading = state is LoginLoadingState;
                          return LoginLoadingButton(
                            isLoading: isLoading,
                            onTap: () {
                              if (!isLoading &&
                                  formKey.currentState!.validate()) {
                                AuthCubit.get(context).login(
                                    userName: userNameController.text.trim(),
                                    password: passwordController.text.trim());
                              }
                            },
                          );
                        },
                      ).animateSlideFade(4,
                          animationDirection: AnimationDirection.bTt),
                    ],
                  )).withPadding(
                (
                  PaddingValues.pDefault.rw,
                  PaddingValues.p120.rh + ScreenUtil().statusBarHeight,
                  PaddingValues.pDefault.rw,
                  PaddingValues.p20.rh + PaddingValues.p30.rh,
                )
                    .pOnlyStartTopEndBottom,
              ),
            )),
          ),
          Positioned(
            left: PaddingValues.p16.rw,
            top: PaddingValues.p16.rh + ScreenUtil().statusBarHeight,
            child: const CustomBackButton().animateSlideFade(2),
          ),
        ],
      ),
    );
  }
}
