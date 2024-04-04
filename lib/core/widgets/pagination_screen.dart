import 'package:flutter/material.dart';
import '/core/extensions/spacer.dart';

import '../extensions/responsive_manager.dart';
import '/core/manager/values_manager.dart';
import '/core/widgets/loading.dart';

class PaginationList<T> extends StatelessWidget {
  const PaginationList({
    Key? key,
    required this.data,
    required this.page,
    required this.maxPages,
    required this.loadMoreData,
    required this.widgetBuilder,
  }) : super(key: key);

  final List<T> data;
  final int page;
  final int maxPages;

  final Function loadMoreData;
  final Widget Function(T dataItem) widgetBuilder;

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
        padding: EdgeInsets.symmetric(
            vertical: PaddingValues.pDefault.rh,
            horizontal: PaddingValues.pDefault.rw),
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < data.length) {
            return widgetBuilder(data[index]);
          } else {
            return const Center(
              child: CustomLoading(),
            );
          }
        },
        separatorBuilder: (context, index) => AppSize.s25.spaceH,
        itemCount: data.length + (page < maxPages ? 1 : 0));
  }
}
