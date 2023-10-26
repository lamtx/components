import 'package:flutter/material.dart';

import '../../components2.dart';
import 'empty_info.dart';
import 'exception_info.dart';
import 'loading_info.dart';

final class AsyncSliverListView extends StatelessWidget {
  const AsyncSliverListView({
    required this.itemCount,
    required this.itemBuilder,
    this.isLoading = false,
    this.emptyInfo = const EmptyInfo(),
    this.exception,
    this.onLoadMore,
    this.onRefresh,
    this.controller,
    super.key,
  });

  final bool isLoading;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Exception? exception;
  final Widget? emptyInfo;
  final VoidCallback? onLoadMore;
  final RefreshCallback? onRefresh;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    Widget listView = SliverList(
      delegate: SliverChildBuilderDelegate(
        itemBuilder,
        childCount: itemCount,
      ),
      // controller: controller,
      // padding: padding ?? safePaddingVertical(context),
      // itemBuilder: itemBuilder,
      // itemCount: itemCount,
      // reverse: reverse,
    );
    if (onRefresh != null) {
      listView = RefreshIndicator(
        onRefresh: onRefresh!,
        child: listView,
      );
    }
    final child = onLoadMore == null
        ? listView
        : NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 22) {
                if (itemCount != 0) {
                  onLoadMore!();
                }
              }
              return false;
            },
            child: Column(
              children: <Widget>[
                Expanded(
                  child: listView,
                ),
                FixedHeightProgressIndicator(
                  isLoading: itemCount != 0 && isLoading,
                )
              ],
            ),
          );
    if (itemCount == 0) {
      return Stack(
        children: <Widget>[
          child,
          if (isLoading)
            const LoadingInfo()
          else if (exception != null)
            ExceptionInfo(exception!)
          else if (emptyInfo != null)
            emptyInfo!,
        ],
      );
    } else {
      return Stack(
        children: <Widget>[
          child,
        ],
      );
    }
  }
}
