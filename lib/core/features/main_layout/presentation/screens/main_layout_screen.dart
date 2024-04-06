import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie_theater/core/cubit/custom_cubit.dart';
import 'package:movie_theater/core/extensions/animations_manager.dart';
import 'package:movie_theater/core/extensions/border_manager.dart';
import 'package:movie_theater/core/extensions/durations.dart';
import 'package:movie_theater/core/extensions/padding_manager.dart';
import 'package:movie_theater/core/extensions/responsive_manager.dart';
import 'package:movie_theater/core/manager/color_manager.dart';
import 'package:movie_theater/core/manager/values_manager.dart';
import 'package:movie_theater/core/widgets/custom_container.dart';
import 'package:movie_theater/core/widgets/custom_svg.dart';

class MainLayoutScreen extends StatelessWidget {
  MainLayoutScreen({
    Key? key,
    required this.icons,
    required this.pages,
  }) : super(key: key);

  final List<String> icons;
  final List<Widget> pages;

  final PageController _pageController = PageController();

  Widget _pageItemBuilder(_, int position) {
    return pages[position];
  }

  void _onBottomNavItemSelected(int itemIndex, BuildContext context) {
    if (itemIndex < pages.length) {
      CustomCubit.get<int>(context).changeState(itemIndex,
          function: () => _pageController.animateToPage(
                itemIndex,
                duration: const Duration(
                  milliseconds: 350,
                ),
                curve: Curves.easeInOut,
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomCubit<int>(0),
      child: AnimationLimiter(
        child: Scaffold(
          body: Stack(
            children: [
              PageView.builder(
                itemCount: pages.length,
                controller: _pageController,
                itemBuilder: _pageItemBuilder,
                physics: const NeverScrollableScrollPhysics(),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: BlocBuilder<CustomCubit<int>, int>(
                  builder: (BuildContext context, int selectedIndex) {
                    return CustomContainer(
                      // isFilled: false,
                      margin: PaddingValues.p35.pSymmetricH,
                      width: double.infinity,
                      height: AppSize.s60.rh,
                      borderRadius: BorderValues.b25.borderAll,
                      borderWidth: AppSize.s1.rs,
                      shadowColor: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.6),
                      color: ColorsManager.transparent,
                      haveShadows: true,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: ClipRRect(
                              borderRadius: BorderValues.b25.borderAll,
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 20.0, sigmaY: 20.0),
                                child: const SizedBox(),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: CustomContainer(
                              borderRadius: BorderValues.b25.borderAll,
                              borderWidth: 0.5,
                              isFilled: false,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                    icons.length,
                                    (index) => CustomContainer(
                                        onTap: () => _onBottomNavItemSelected(
                                            index, context),
                                        transparentButton: true,
                                        child: CustomSvg(icons[index]))),
                              ).withPadding(PaddingValues.p50.pSymmetricH),
                            ),
                          ),
                          AnimatedPositioned(
                            duration: DurationValues.dm250.milliseconds,
                            left: selectedIndex == 0
                                ? AppSize.s1_5.rw
                                : selectedIndex == 1
                                    ? (AppSize.s100 + AppSize.s16 + AppSize.s3)
                                        .rw
                                    : ((AppSize.s100 +
                                                AppSize.s16 +
                                                AppSize.s2) *
                                            2)
                                        .rw,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomContainer(
                                  width: AppSize.s30.rw,
                                  height: AppSize.s40.rh,
                                  gradient: LinearGradient(
                                      colors: [
                                        ColorsManager.redColor.withOpacity(0),
                                        ColorsManager.redColor.withOpacity(0.1),
                                        ColorsManager.redColor.withOpacity(0.1),
                                        ColorsManager.redColor.withOpacity(0.3),
                                        ColorsManager.redColor.withOpacity(0.4),
                                        ColorsManager.redColor.withOpacity(0.7),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                  borderRadius: BorderRadius.zero,
                                  child: const SizedBox(),
                                ),
                                CustomContainer(
                                  haveShadows: true,
                                  width: AppSize.s40.rw,
                                  height: AppSize.s4.rh,
                                  child: const SizedBox(),
                                )
                              ],
                            ).withPadding(PaddingValues.p40.pSymmetricH),
                          )
                        ],
                      ),
                    );
                  },
                ).withPadding(PaddingValues.p45.pOnlyBottom).animateSlideFade(1,
                    animationDirection: AnimationDirection.bTt),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/**
 * 
 * BottomNavigationBar(
              currentIndex: state,
              items: bottomNavigationBarItems,
              onTap: (int index) => _onBottomNavItemSelected(index, context),
            )
 * 
 */