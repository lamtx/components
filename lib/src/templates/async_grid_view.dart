import 'package:flutter/material.dart';

import '../../components.dart';
import 'empty_info.dart';
import 'exception_info.dart';
import 'loading_info.dart';

class AsyncGridView extends StatelessWidget {
  const AsyncGridView({
    Key? key,
    required this.itemCount,
    required this.itemExtent,
    required this.columnCount,
    required this.itemBuilder,
    this.exception,
    this.emptyInfo = const EmptyInfo(),
    this.isLoading = false,
    this.padding,
    this.onLoadMore,
    this.physics,
  }) : super(key: key);

  final bool isLoading;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Exception? exception;
  final Widget? emptyInfo;
  final EdgeInsets? padding;
  final double itemExtent;
  final int columnCount;
  final VoidCallback? onLoadMore;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    if (isLoading && itemCount == 0) {
      return const LoadingInfo();
    }
    final padding = this.padding ?? EdgeInsets.zero;
    final size = MediaQuery.of(context).size;
    final itemWidth = (size.width - padding.left - padding.right) / columnCount;
    final gridView = GridView.builder(
      padding: padding,
      itemCount: itemCount,
      physics: physics,
      itemBuilder: itemBuilder,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnCount,
        childAspectRatio: itemWidth / itemExtent,
      ),
    );
    final child = onLoadMore == null
        ? gridView
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
                  child: gridView,
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
          if (exception != null)
            ExceptionInfo(exception!)
          else if (emptyInfo != null)
            emptyInfo!,
        ],
      );
    } else {
      return child;
    }
  }
}
