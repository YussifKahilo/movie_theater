import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension MSpacer on num {
  /// sh add space in a vertical way according to the prefix number [10.sh]
  SizedBox get spaceH => SizedBox(
        height: toDouble().h,
      );

  /// sw add space in a horizontal way according to the prefix number [10.sw]
  SizedBox get spaceW => SizedBox(
        width: toDouble().w,
      );
}
