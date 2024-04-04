import 'package:flutter/material.dart';

import '../manager/strings_manager.dart';
import 'toast.dart';

// ignore: must_be_immutable
class BackAgainScreenHolder extends StatelessWidget {
  final Widget child;
  DateTime preBackPress = DateTime.now();

  BackAgainScreenHolder({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.canPop(context)) {
          return true;
        }
        final timeGap = DateTime.now().difference(preBackPress);
        final canExit = timeGap < const Duration(seconds: 2);
        preBackPress = DateTime.now();
        if (canExit) {
          return true; // true will exit the app
        } else {
          showToast(StringsManager.pressBackButtonAgainToExit, time: 2);
          return false; // false will do nothing when back press
        }
      },
      child: child,
    );
  }
}
