import 'package:flutter/material.dart';

import 'package:movie_theater/core/extensions/padding_manager.dart';

import '/core/extensions/spacer.dart';
import '/core/manager/values_manager.dart';
import '/core/widgets/loading.dart';

class PaginationList extends StatelessWidget {
  const PaginationList({
    Key? key,
    required this.maxPages,
    required this.dataLength,
    this.padding,
    required this.loadMoreData,
    required this.widgetBuilder,
    this.separator,
  }) : super(key: key);

  final int maxPages;
  final int dataLength;
  final EdgeInsetsDirectional? padding;
  final Function(int nextPage) loadMoreData;
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
        loadMoreData(++page);
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
