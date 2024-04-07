import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/theme/themes_manager.dart';
import '../manager/color_manager.dart';
import '/core/widgets/custom_text.dart';
import 'custom_container.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final PreferredSizeWidget? bottom;
  final Color? titleColor;
  final Color? backGroundColor;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final double? elevation;
  bool showLeading;

  void Function()? onBackClick;

  CustomAppBar({
    Key? key,
    this.title,
    this.elevation,
    this.showLeading = false,
    this.titleWidget,
    this.titleColor,
    this.backGroundColor,
    this.centerTitle = false,
    this.actions,
    this.leading,
    this.onBackClick,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void popBack() {
      Navigator.pop(context);
    }

    if (leading != null) showLeading = true;
    return AppBar(
      bottom: bottom,
      backgroundColor: backGroundColor,
      elevation: elevation,
      automaticallyImplyLeading: showLeading,
      leading: showLeading
          ? leading ??
              CustomContainer(
                shape: BoxShape.circle,
                color: ColorsManager.transparent,
                onTap: onBackClick != null ? onBackClick! : popBack,
                child: const Icon(Icons.arrow_back_ios_new),
              )
          : null,
      centerTitle: centerTitle,
      actions: actions,
      title: titleWidget ??
          (title == null
              ? null
              : CustomText(
                  title!,
                  textStyle: ThemesManager.getBodyLargeTextStyle(context)
                      .copyWith(color: titleColor),
                )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
