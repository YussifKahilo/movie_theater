import 'package:flutter/widgets.dart';
import 'package:movie_theater/core/extensions/spacer.dart';

import '../../../../core/manager/assets_manager.dart';
import '../../../../core/manager/color_manager.dart';
import '../../../../core/manager/values_manager.dart';
import '../../../../core/widgets/custom_svg.dart';
import '../../../../core/widgets/custom_text.dart';

class StartSearchWidget extends StatelessWidget {
  const StartSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomSvg(
            AssetsManager.searchIcon,
            color: ColorsManager.primaryColor,
            size: AppSize.s150,
          ),
          AppSize.s30.spaceH,
          const CustomText(
            "let's Search for a movie !",
            color: ColorsManager.primaryColor,
          ),
          AppSize.s50.spaceH,
        ],
      ),
    );
  }
}
