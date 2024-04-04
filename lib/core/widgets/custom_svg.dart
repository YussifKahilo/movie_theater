import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../extensions/responsive_manager.dart';

class CustomSvg extends StatelessWidget {
  final String path;
  final num? size;
  final Color? color;
  const CustomSvg(this.path, {super.key, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path, width: size?.rc,
      height: size?.rs,
      // ignore: deprecated_member_use
      color: color ?? Theme.of(context).iconTheme.color,
    );
  }
}
