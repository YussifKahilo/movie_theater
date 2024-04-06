import 'package:flutter/material.dart';
import 'package:movie_theater/core/features/main_layout/presentation/screens/main_layout_screen.dart';
import 'package:movie_theater/core/manager/assets_manager.dart';
import 'package:movie_theater/features/movies/presentation/screens/home_screen.dart';

class LayoutScreen extends StatelessWidget {
  LayoutScreen({super.key});

  final List<Widget> pages = [
    const HomeScreen(),
    const SizedBox(),
    const SizedBox()
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayoutScreen(icons: const [
      AssetsManager.homeIcon,
      AssetsManager.searchIcon,
      AssetsManager.heartIcon,
    ], pages: pages);
  }
}
