import 'package:flutter/material.dart';

import 'empty_info.dart';
import 'exception_info.dart';
import 'loading_info.dart';

final class AsyncSliverGridView extends StatelessWidget {
  const AsyncSliverGridView({
    required this.itemCount,
    required this.itemExtent,
    required this.columnCount,
    required this.itemBuilder,
    required this.isLoading,
    this.exception,
    this.emptyInfo = const EmptyInfo(),
    this.onLoadMore,
    this.padding = EdgeInsets.zero,
    super.key,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Exception? exception;
  final Widget? emptyInfo;
  final double itemExtent;
  final int columnCount;
  final VoidCallback? onLoadMore;
  final bool isLoading;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    if (itemCount != 0) {
      return _buildList(context);
    } else if (isLoading) {
      return const LoadingInfo().toBoxAdapter();
    } else if (exception != null) {
      return ExceptionInfo(exception!).toBoxAdapter();
    } else if (emptyInfo != null) {
      return emptyInfo!.toBoxAdapter();
    } else {
      return const SizedBox.shrink().toBoxAdapter();
    }
  }

  Widget _buildList(BuildContext context) {
    final size =
        MediaQuery.of(context).size.width - padding.left - padding.right;
    final itemWidth = size / columnCount;
    return SliverPadding(
      padding: padding,
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columnCount,
          childAspectRatio: itemWidth / itemExtent,
        ),
        delegate: SliverChildBuilderDelegate(
          onLoadMore == null
              ? itemBuilder
              : (context, position) {
                  if (position == itemCount - 1) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      onLoadMore!.call();
                    });
                  }
                  return itemBuilder(context, position);
                },
          childCount: itemCount,
        ),
      ),
    );
  }
}

extension on Widget {
  Widget toBoxAdapter() {
    return SliverToBoxAdapter(child: this);
  }
}
