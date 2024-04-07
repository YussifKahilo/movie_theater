import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import '/core/manager/strings_manager.dart';

void showSnackBar(
    {ContentType? contentType,
    String? title,
    required BuildContext context,
    required String content}) {
  String defTitle = contentType == null
      ? StringsManager.error
      : contentType == ContentType.success
          ? StringsManager.success
          : StringsManager.warning;
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title ?? defTitle,
      message: content,
      contentType: contentType ?? ContentType.failure,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
