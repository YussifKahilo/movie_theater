import 'package:flutter/material.dart';

import '../../config/theme/themes_manager.dart';
import '/core/manager/color_manager.dart';
import '../extensions/responsive_manager.dart';
import '../manager/values_manager.dart';
import 'custom_svg.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final Function(String newValue)? onChanged;
  final Widget? leftIcon;
  final String? svgIcon;
  final Widget? rightIcon;
  final String? Function(String? value)? validator;

  final FocusNode? focusNode;
  final TextAlign textAlign;
  final int? maxLength;
  final InputBorder? border;
  final InputBorder? focusedBorder;

  const CustomTextField(
      {Key? key,
      this.hintText,
      this.rightIcon,
      required this.controller,
      required this.textInputType,
      this.onChanged,
      this.leftIcon,
      this.validator,
      this.border,
      this.focusNode,
      this.focusedBorder,
      this.maxLength,
      this.textAlign = TextAlign.start,
      this.svgIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: textInputType,
      cursorColor: ColorsManager.primaryColor,
      onChanged: onChanged,
      focusNode: focusNode,
      textAlign: textAlign,
      maxLength: maxLength,
      style: ThemesManager.getBodySmallTextStyle(context),
      decoration: InputDecoration(
        border: border,
        focusedBorder: focusedBorder,
        suffixIcon: rightIcon,
        prefixIcon: leftIcon ??
            (svgIcon == null
                ? null
                : Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: PaddingValues.p15.rw,
                    ),
                    child: CustomSvg(
                      svgIcon!,
                      color: Theme.of(context)
                          .inputDecorationTheme
                          .suffixIconColor,
                    ),
                  )),
        hintText: hintText,
      ),
    );
  }
}
