import 'dart:developer';

import 'package:flutter/foundation.dart';

extension DebugPrint on dynamic {
  void dPrint() {
    if (kDebugMode) {
      print(this);
    }
  }

  void dLog() {
    if (kDebugMode) {
      log(toString());
    }
  }
}
