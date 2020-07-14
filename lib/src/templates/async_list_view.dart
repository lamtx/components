import 'package:flutter/material.dart';

import '../../components.dart';
import 'empty_info.dart';
import 'exception_info.dart';
import 'loading_info.dart';
import 'safe_padding.dart';

class AsyncListView extends StatelessWidget {
  const AsyncListView({
    Key key,
    @required this.itemCount,
    @required this.itemBuilder,
    this.reverse = false,
    this.isLoading = false,
    this.emptyInfo = const EmptyInfo(),
    this.exception,
    this.padding,
    this.onLoadMore,
    this.onRefresh,
  })  : assert(itemCount != null),
        assert(itemBuilder != null),
        super(key: key);

  final bool isLoading;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Exception exception;
  final Widget emptyInfo;
  final EdgeInsets padding;
  final VoidCallback onLoadMore;
  final bool reverse;
  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    Widget listView = ListView.builder(
      padding: padding ?? safePaddingVertical(context),
      itemBuilder: itemBuilder,
      itemCount: itemCount,
      reverse: reverse,
    );
    if (onRefresh != null) {
      listView = RefreshIndicator(
        onRefresh: onRefresh,
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
                  onLoadMore();
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
            const LoadingInfo()
          else if (exception != null)
            ExceptionInfo(exception)
          else if (emptyInfo != null)
            emptyInfo,
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
