import 'package:flutter/material.dart';
import 'package:movie_theater/core/manager/fonts_manager.dart';
import '/core/manager/values_manager.dart';
import '../../core/manager/color_manager.dart';
import '../../core/extensions/responsive_manager.dart';

class Themes {
  static AppBarTheme _appBarTheme(ThemeData themeData) {
    return AppBarTheme(
      backgroundColor: ColorsManager.transparent,
      actionsIconTheme: themeData.iconTheme,
      elevation: 0,
      iconTheme: themeData.iconTheme,
    );
  }

  static InputBorder _customBorder(Color color) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(BorderValues.b10.rc),
        borderSide: BorderSide(color: color, width: 1.5));
  }

  static TabBarTheme _customTabBar(Color color) {
    return TabBarTheme(
      indicatorColor: color,
      labelColor: color,
      overlayColor: MaterialStateProperty.all<Color>(color.withOpacity(0.2)),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: color),
      ),
    );
  }

  static CheckboxThemeData _checkBoxThemeData() {
    return const CheckboxThemeData(
      shape: CircleBorder(),
    );
  }

  static ThemeData getLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      bottomNavigationBarTheme: _lightBottomNavBar(),
      scaffoldBackgroundColor: ColorsManager.greyExtraLightColor,
      primaryColor: ColorsManager.primaryColor,
      splashColor: ColorsManager.primaryLightColor,
      appBarTheme: _appBarTheme(ThemeData.light()),
      iconTheme: const IconThemeData(
        color: ColorsManager.greyColor,
      ),
      textTheme: _textTheme(ColorsManager.blackColor),
      checkboxTheme: _checkBoxThemeData(),
      hintColor: ColorsManager.greyExtraLightColor,
      inputDecorationTheme: _lightInputDecoratorTheme(),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorsManager.primaryColor,
      ),
      tabBarTheme: _customTabBar(Colors.black),
    );
  }

  static InputDecorationTheme _lightInputDecoratorTheme() {
    return InputDecorationTheme(
      contentPadding: EdgeInsetsDirectional.symmetric(
        vertical: PaddingValues.p5.rh,
        horizontal: PaddingValues.p20.rw,
      ),
      errorStyle: ThemeData.light().textTheme.headlineMedium!.copyWith(
            color: ColorsManager.redColor,
          ),
      hintStyle: ThemeData.light()
          .textTheme
          .bodyMedium!
          .copyWith(color: ColorsManager.primaryColor),
      prefixIconColor: ColorsManager.primaryColor,
      suffixIconColor: ColorsManager.primaryColor,
      filled: true,
      fillColor: ThemeData.light().scaffoldBackgroundColor,
      errorBorder: _customBorder(ColorsManager.redColor),
      focusedBorder: _customBorder(ColorsManager.primaryColor),
      focusedErrorBorder: _customBorder(ColorsManager.primaryColor),
      border: _customBorder(ColorsManager.greyLightColor),
      enabledBorder: _customBorder(ColorsManager.greyLightColor),
    );
  }

  static BottomNavigationBarThemeData _lightBottomNavBar() {
    return const BottomNavigationBarThemeData(
      elevation: AppSize.s20,
      backgroundColor: ColorsManager.whiteColor,
      selectedItemColor: ColorsManager.primaryColor,
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ColorsManager.greyDarkColor,
      primaryColor: ColorsManager.primaryColor,
      splashColor: ColorsManager.primaryLightColor,
      bottomNavigationBarTheme: _darkBottomNavBar(),
      appBarTheme: _appBarTheme(ThemeData.dark()),
      iconTheme: const IconThemeData(
        color: ColorsManager.greyExtraLightColor,
      ),
      textTheme: _textTheme(ColorsManager.whiteColor),
      checkboxTheme: _checkBoxThemeData(),
      inputDecorationTheme: _darkInputDecoratorTheme(),
      tabBarTheme: _customTabBar(Colors.white),
    );
  }

  static InputDecorationTheme _darkInputDecoratorTheme() {
    return InputDecorationTheme(
        contentPadding: EdgeInsetsDirectional.symmetric(
          vertical: PaddingValues.p5.rh,
          horizontal: PaddingValues.p20.rw,
        ),
        errorStyle: ThemeData.dark()
            .textTheme
            .headlineMedium!
            .copyWith(color: ColorsManager.redColor),
        hintStyle: ThemeData.dark()
            .textTheme
            .bodyMedium!
            .copyWith(color: ColorsManager.primaryColor),
        prefixIconColor: ColorsManager.primaryColor,
        suffixIconColor: ColorsManager.primaryColor,
        filled: true,
        fillColor: ThemeData.dark().scaffoldBackgroundColor,
        errorBorder: _customBorder(ColorsManager.redColor),
        focusedBorder: _customBorder(ColorsManager.primaryColor),
        focusedErrorBorder: _customBorder(ColorsManager.primaryColor),
        border: _customBorder(ColorsManager.transparent),
        enabledBorder: _customBorder(ColorsManager.transparent));
  }

  static BottomNavigationBarThemeData _darkBottomNavBar() {
    return const BottomNavigationBarThemeData(
      elevation: AppSize.s20,
      backgroundColor: ColorsManager.greyDarkColor,
      selectedItemColor: ColorsManager.primaryColor,
    );
  }

  static TextTheme _textTheme(Color color) => TextTheme(
        displaySmall: FontStyles.getMediumStyle()
            .copyWith(color: color, fontSize: FontSize.f8),
        displayMedium: FontStyles.getMediumStyle()
            .copyWith(color: color, fontSize: FontSize.f10),
        displayLarge: FontStyles.getMediumStyle()
            .copyWith(color: color, fontSize: FontSize.f12),
        bodySmall: FontStyles.getMediumStyle()
            .copyWith(color: color, fontSize: FontSize.f14),
        bodyMedium: FontStyles.getMediumStyle()
            .copyWith(color: color, fontSize: FontSize.f16),
        bodyLarge: FontStyles.getMediumStyle()
            .copyWith(color: color, fontSize: FontSize.f18),
        titleSmall: FontStyles.getBoldStyle()
            .copyWith(color: color, fontSize: FontSize.f20),
        titleMedium: FontStyles.getBoldStyle()
            .copyWith(color: color, fontSize: FontSize.f22),
        titleLarge: FontStyles.getBoldStyle()
            .copyWith(color: color, fontSize: FontSize.f24),
      );
}

class ThemesManager {
  static TextStyle getTitleLargeTextStyle(context) =>
      Theme.of(context).textTheme.titleLarge!;

  static TextStyle getTitleMediumTextStyle(context) =>
      Theme.of(context).textTheme.titleMedium!;

  static TextStyle getTitleSmallTextStyle(context) =>
      Theme.of(context).textTheme.titleSmall!;

  static TextStyle getBodyLargeTextStyle(context) =>
      Theme.of(context).textTheme.bodyLarge!;

  static TextStyle getBodyMediumTextStyle(context) =>
      Theme.of(context).textTheme.bodyMedium!;

  static TextStyle getBodySmallTextStyle(context) =>
      Theme.of(context).textTheme.bodySmall!;

  static TextStyle getDisplayLargeTextStyle(context) =>
      Theme.of(context).textTheme.displayLarge!;

  static TextStyle getDisplayMediumTextStyle(context) =>
      Theme.of(context).textTheme.displayMedium!;

  static TextStyle getDisplaySmallTextStyle(context) =>
      Theme.of(context).textTheme.displaySmall!;
}
