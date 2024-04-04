import 'package:flutter/material.dart';

class FontConstants {
  static const String fontFamily = 'Poppins';
}

class FontWeightManager {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

class FontStyles {
  static TextStyle getThinStyle() {
    return const TextStyle(
        fontFamily: FontConstants.fontFamily,
        fontWeight: FontWeightManager.thin);
  }

  static TextStyle getExtraLightStyle() {
    return const TextStyle(
        fontFamily: FontConstants.fontFamily,
        fontWeight: FontWeightManager.extraLight);
  }

  static TextStyle getLightStyle() {
    return const TextStyle(
        fontFamily: FontConstants.fontFamily,
        fontWeight: FontWeightManager.light);
  }

  static TextStyle getRegularStyle() {
    return const TextStyle(
        fontFamily: FontConstants.fontFamily,
        fontWeight: FontWeightManager.regular);
  }

  static TextStyle getMediumStyle() {
    return const TextStyle(
        fontFamily: FontConstants.fontFamily,
        fontWeight: FontWeightManager.medium);
  }

  static TextStyle getSemiBoldStyle() {
    return const TextStyle(
        fontFamily: FontConstants.fontFamily,
        fontWeight: FontWeightManager.semiBold);
  }

  static TextStyle getBoldStyle() {
    return const TextStyle(
        fontFamily: FontConstants.fontFamily,
        fontWeight: FontWeightManager.bold);
  }

  static TextStyle getExtraBoldStyle() {
    return const TextStyle(
        fontFamily: FontConstants.fontFamily,
        fontWeight: FontWeightManager.extraBold);
  }

  static TextStyle getBlackStyle() {
    return const TextStyle(
        fontFamily: FontConstants.fontFamily,
        fontWeight: FontWeightManager.black);
  }
}

class FontSize {
  static const double f8 = 8;
  static const double f10 = 10;
  static const double f12 = 12;
  static const double f14 = 14;
  static const double f15 = 15;
  static const double f16 = 16;
  static const double f17 = 17;
  static const double f18 = 18;
  static const double f20 = 20;
  static const double f22 = 22;
  static const double f24 = 24;
  static const double f25 = 58;
  static const double f26 = 26;
  static const double f28 = 28;
  static const double f30 = 30;
  static const double f32 = 32;
  static const double f34 = 34;
  static const double f35 = 35;
  static const double f45 = 45;
}
