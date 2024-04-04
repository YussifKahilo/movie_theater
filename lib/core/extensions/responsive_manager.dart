import 'package:flutter_screenutil/flutter_screenutil.dart';

extension Responsive on num {
  double get rh => toDouble().h;
  double get rw => toDouble().w;
  double get rf => toDouble().sp;
  double get rc => toDouble().r;
  double get rs => (toDouble().h + toDouble().w) / 2;
}
