import 'package:flutter/widgets.dart';

import 'package:movie_theater/core/extensions/spacer.dart';

import '../../../../core/manager/assets_manager.dart';
import '../../../../core/manager/color_manager.dart';
import '../../../../core/manager/values_manager.dart';
import '../../../../core/widgets/custom_svg.dart';
import '../../../../core/widgets/custom_text.dart';

class NoResultsWidget extends StatelessWidget {
  const NoResultsWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomSvg(
            AssetsManager.noResults,
            useColor: false,
            size: AppSize.s200,
          ),
          AppSize.s30.spaceH,
          CustomText(
            'No results for "$title"',
            color: ColorsManager.primaryColor,
          ),
          AppSize.s50.spaceH,
        ],
      ),
    );
  }
}
