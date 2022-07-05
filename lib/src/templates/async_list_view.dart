import 'package:flutter/material.dart';

import '../../components2.dart';
import 'safe_padding.dart';
import 'utilities.dart';

class AsyncListView extends StatelessWidget {
  const AsyncListView({
    required this.itemCount,
    required this.itemBuilder,
    this.separatorBuilder,
    this.reverse = false,
    this.isLoading = false,
    this.exception,
    this.emptyInfoBuilder = defaultEmptyBuilder,
    this.loadingInfoBuilder = defaultLoadingBuilder,
    this.exceptionBuilder = defaultExceptionBuilder,
    this.padding,
    this.onLoadMore,
    this.onRefresh,
    this.controller,
    this.physics,
    super.key,
  });

  final bool isLoading;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final Exception? exception;
  final ExceptionWidgetBuilder exceptionBuilder;
  final WidgetBuilder emptyInfoBuilder;
  final WidgetBuilder loadingInfoBuilder;
  final EdgeInsets? padding;
  final VoidCallback? onLoadMore;
  final bool reverse;
  final RefreshCallback? onRefresh;
  final ScrollController? controller;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    Widget listView = separatorBuilder == null
        ? ListView.builder(
            controller: controller,
            padding: padding ?? safePaddingVertical(context),
            itemBuilder: itemBuilder,
            itemCount: itemCount,
            reverse: reverse,
            physics: physics,
          )
        : ListView.separated(
            controller: controller,
            itemBuilder: itemBuilder,
            padding: padding ?? safePaddingVertical(context),
            separatorBuilder: separatorBuilder!,
            itemCount: itemCount,
            physics: physics,
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
                if (reverse)
                  FixedHeightProgressIndicator(
                    isLoading: itemCount != 0 && isLoading,
                  ),
                Expanded(
                  child: listView,
                ),
                if (!reverse)
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
            loadingInfoBuilder(context)
          else if (exception != null)
            exceptionBuilder(context, exception!)
          else
            emptyInfoBuilder(context),
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
