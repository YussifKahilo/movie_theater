import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/core/manager/fonts_manager.dart';
import '/core/manager/values_manager.dart';
import '../manager/color_manager.dart';
import '../extensions/responsive_manager.dart';

void showToast(String msg,
    {int time = Values.toastTime,
    Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity toastGravity = ToastGravity.BOTTOM,
    Color backGroundColor = ColorsManager.greyDarkColor,
    Color textColor = ColorsManager.whiteColor,
    double fontSize = FontSize.f16}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: msg,
    toastLength: toastLength,
    gravity: toastGravity,
    backgroundColor: backGroundColor,
    timeInSecForIosWeb: time,
    webPosition: 'center',
    textColor: textColor,
    fontSize: fontSize.rf,
  );
}
