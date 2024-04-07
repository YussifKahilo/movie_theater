import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/custom_cubit.dart';
import '/core/extensions/padding_manager.dart';
import '/config/theme/themes_manager.dart';

import '../manager/assets_manager.dart';
import '../manager/color_manager.dart';
import '../manager/values_manager.dart';
import 'custom_container.dart';

import 'custom_svg.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Widget? icon;
  final String? svgIcon;

  final Function(String newValue)? onChanged;
  final String? Function(String?)? validator;

  const CustomPasswordField(
      {Key? key,
      required this.controller,
      this.hintText,
      this.icon,
      this.onChanged,
      this.validator,
      this.svgIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomCubit<bool>(true),
      child: BlocBuilder<CustomCubit<bool>, bool>(
        builder: (context, state) {
          return TextFormField(
            obscureText: state,
            controller: controller,
            validator: validator,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: ColorsManager.primaryColor,
            onChanged: onChanged,
            style: ThemesManager.getBodySmallTextStyle(context),
            decoration: InputDecoration(
                prefixIcon: icon ??
                    (svgIcon == null
                        ? null
                        : CustomSvg(
                            svgIcon!,
                            color: Theme.of(context)
                                .inputDecorationTheme
                                .suffixIconColor,
                          ).withPadding(PaddingValues.p15.pSymmetricH)),
                hintText: hintText,
                suffixIcon: Padding(
                  padding: PaddingValues.p15.pOnlyEnd,
                  child: CustomContainer(
                    color: ColorsManager.transparent,
                    shape: BoxShape.circle,
                    onTap: () =>
                        CustomCubit.get<bool>(context).changeState(!state),
                    child: state
                        ? CustomSvg(
                            AssetsManager.eyeClosedIcon,
                            color: Theme.of(context)
                                .inputDecorationTheme
                                .suffixIconColor,
                          )
                        : CustomSvg(AssetsManager.eyeOpenIcon,
                            color: Theme.of(context)
                                .inputDecorationTheme
                                .suffixIconColor),
                  ),
                )),
          );
        },
      ),
    );
  }
}
