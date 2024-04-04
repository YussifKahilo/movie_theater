// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '/core/manager/values_manager.dart';

class _SlideFadeAnimation extends StatelessWidget {
  const _SlideFadeAnimation({
    Key? key,
    required this.child,
    this.horizontalOffset,
    this.verticalOffset,
    this.reverseHorizontal = false,
  }) : super(key: key);

  final Widget child;
  final double? horizontalOffset;
  final double? verticalOffset;
  final bool reverseHorizontal;

  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
        verticalOffset: verticalOffset,
        horizontalOffset:
            -(horizontalOffset ?? AppSize.s150) * (reverseHorizontal ? -1 : 1),
        child: FadeInAnimation(child: child));
  }
}

class _GridAnimation extends StatelessWidget {
  const _GridAnimation({
    Key? key,
    required this.position,
    required this.columnCount,
    required this.child,
    this.delay,
    this.duration,
  }) : super(key: key);

  final int position;
  final int columnCount;
  final Widget child;
  final int? delay;
  final int? duration;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
        duration: Duration(milliseconds: duration ?? 350),
        delay: Duration(milliseconds: delay ?? 150),
        position: position,
        columnCount: columnCount,
        child: child);
  }
}

class _ListAnimation extends StatelessWidget {
  const _ListAnimation({
    Key? key,
    required this.position,
    required this.child,
    this.delay,
    this.duration,
  }) : super(key: key);

  final int position;
  final Widget child;
  final int? delay;
  final int? duration;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
        duration: Duration(milliseconds: duration ?? 350),
        delay: Duration(milliseconds: delay ?? 150),
        position: position,
        child: child);
  }
}

class ListSLiderFadeAnimation extends StatelessWidget {
  const ListSLiderFadeAnimation({
    Key? key,
    required this.position,
    required this.child,
    this.reverseHorizontal = false,
    this.delay,
    this.duration,
    this.horizontalOffset,
    this.verticalOffset,
  }) : super(key: key);

  final int position;
  final Widget child;
  final int? delay;
  final int? duration;
  final double? horizontalOffset;
  final double? verticalOffset;
  final bool reverseHorizontal;

  @override
  Widget build(BuildContext context) {
    return _ListAnimation(
        delay: delay,
        duration: duration,
        position: position,
        child: _SlideFadeAnimation(
            reverseHorizontal: reverseHorizontal,
            horizontalOffset: horizontalOffset,
            verticalOffset: verticalOffset,
            child: child));
  }
}

class GridSLiderFadeAnimation extends StatelessWidget {
  const GridSLiderFadeAnimation({
    Key? key,
    required this.position,
    required this.child,
    this.delay,
    this.duration,
    required this.columnCount,
    this.horizontalOffset,
    this.verticalOffset,
  }) : super(key: key);

  final int position;
  final Widget child;
  final int? delay;
  final int? duration;
  final int columnCount;
  final double? horizontalOffset;
  final double? verticalOffset;

  @override
  Widget build(BuildContext context) {
    return _GridAnimation(
        columnCount: columnCount,
        position: position,
        delay: delay,
        duration: duration,
        child: _SlideFadeAnimation(
            horizontalOffset: horizontalOffset,
            verticalOffset: verticalOffset,
            child: child));
  }
}
