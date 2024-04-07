import 'package:flutter/material.dart';

import 'package:movie_theater/core/extensions/padding_manager.dart';

import '/core/extensions/spacer.dart';
import '/core/manager/values_manager.dart';
import '/core/widgets/loading.dart';

class PaginationList<T> extends StatelessWidget {
  const PaginationList({
    Key? key,
    required this.page,
    required this.maxPages,
    required this.dataLength,
    this.padding,
    required this.loadMoreData,
    required this.widgetBuilder,
    this.separator,
  }) : super(key: key);

  final int page;
  final int maxPages;
  final int dataLength;
  final EdgeInsetsDirectional? padding;
  final Function() loadMoreData;
  final Widget Function(int index) widgetBuilder;
  final double? separator;

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    scrollController.addListener(() {
      if ((scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) &&
          page < maxPages) {
        loadMoreData();
      }
    });
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: padding ?? PaddingValues.pDefault.pSymmetricVH,
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < dataLength) {
            return widgetBuilder(index);
          } else {
            return const Center(
              child: CustomLoading(),
            );
          }
        },
        separatorBuilder: (context, index) => (separator ?? AppSize.s25).spaceH,
        itemCount: dataLength + (page < maxPages ? 1 : 0));
  }
}

class PaginationGrid extends StatelessWidget {
  const PaginationGrid({
    Key? key,
    required this.page,
    required this.maxPages,
    required this.dataLength,
    this.padding,
    required this.loadMoreData,
    required this.widgetBuilder,
    this.separator,
  }) : super(key: key);

  final int page;
  final int maxPages;
  final int dataLength;
  final EdgeInsetsDirectional? padding;
  final Function() loadMoreData;
  final Widget Function(int index) widgetBuilder;
  final double? separator;

  @override
  Widget build(BuildContext context) {
    int page = 1;
    ScrollController scrollController = ScrollController();
    scrollController.addListener(() {
      if ((scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) &&
          page < maxPages) {
        loadMoreData();
      }
    });
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: padding ?? PaddingValues.pDefault.pSymmetricVH,
      controller: scrollController,
      child: Column(
          children: List.generate(
              (dataLength / 2).ceil() + (page < maxPages ? 1 : 0), (index) {
        int currentIndex = index * 2;
        if (currentIndex < dataLength) {
          return Row(
            children: [
              Expanded(child: widgetBuilder(currentIndex)),
              (separator ?? AppSize.s25).spaceW,
              Expanded(
                  child: currentIndex + 1 < dataLength
                      ? widgetBuilder(currentIndex + 1)
                      : const SizedBox()),
            ],
          ).withPadding((separator ?? PaddingValues.p25).pOnlyBottom);
        } else {
          return const Center(
            child: CustomLoading(),
          );
        }
      })),
    );
  }
}
