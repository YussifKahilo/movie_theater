import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_theater/core/extensions/padding_manager.dart';
import 'package:movie_theater/core/features/main_layout/presentation/screens/main_layout_screen.dart';
import 'package:movie_theater/core/manager/assets_manager.dart';
import 'package:movie_theater/core/manager/color_manager.dart';
import 'package:movie_theater/core/widgets/custom_container.dart';
import 'package:movie_theater/features/movies/presentation/screens/home_screen.dart';

import '../../../../core/network/cubit/network_connectivity_cubit.dart';

class LayoutScreen extends StatefulWidget {
  LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  final List<Widget> pages = [
    const HomeScreen(),
    const SizedBox(),
    const SizedBox()
  ];

  @override
  void initState() {
    NetworkConnectivityCubit.get(context).checkConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainLayoutScreen(icons: const [
          AssetsManager.homeIcon,
          AssetsManager.searchIcon,
          AssetsManager.heartIcon,
        ], pages: pages),
        Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: BlocBuilder<NetworkConnectivityCubit, bool>(
              builder: (context, state) {
                return Visibility(
                  visible: !state,
                  child: CustomContainer(
                    padding: (ScreenUtil().bottomBarHeight / 2).pOnlyBottom,
                    color: ColorsManager.primaryDarkColor,
                    text: 'You are not connected to internet',
                  ),
                );
              },
            ))
      ],
    );
  }
}
