import 'dart:io';

import 'package:flutter/material.dart';
import '/core/manager/color_manager.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key, this.backgroundColor, this.color})
      : super(key: key);

  final Color? backgroundColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: backgroundColor == null
            ? (Platform.isAndroid
                ? Colors.black.withOpacity(0.6)
                : Colors.black.withOpacity(0.8))
            : (Platform.isAndroid
                ? backgroundColor?.withOpacity(0.6)
                : backgroundColor?.withOpacity(0.8)),
        body: Center(
          child: CustomLoading(
            color: color,
          ),
        ),
      ),
    );
  }
}

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    Key? key,
    this.color,
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive(
      valueColor:
          AlwaysStoppedAnimation<Color>(color ?? ColorsManager.primaryColor),
      backgroundColor: Platform.isAndroid
          ? ColorsManager.transparent
          : color ?? ColorsManager.primaryColor,
    );
  }
}
