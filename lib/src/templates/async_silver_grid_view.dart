import 'package:flutter/material.dart';

import 'empty_info.dart';
import 'exception_info.dart';
import 'loading_info.dart';

class AsyncSliverGridView extends StatelessWidget {
  const AsyncSliverGridView({
    Key? key,
    required this.itemCount,
    required this.itemExtent,
    required this.columnCount,
    required this.itemBuilder,
    this.exception,
    this.emptyInfo = const EmptyInfo(),
    this.onLoadMore,
    required this.isLoading,
  }) : super(key: key);

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Exception? exception;
  final Widget? emptyInfo;
  final double itemExtent;
  final int columnCount;
  final VoidCallback? onLoadMore;
  final bool isLoading;

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
    final size = MediaQuery.of(context).size;
    final itemWidth = size.width / columnCount;
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnCount,
        childAspectRatio: itemWidth / itemExtent,
      ),
      delegate: SliverChildBuilderDelegate(
        onLoadMore == null
            ? itemBuilder
            : (context, position) {
                if (position == itemCount - 1) {
                  WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                    onLoadMore!.call();
                  });
                }
                return itemBuilder(context, position);
              },
        childCount: itemCount,
      ),
    );
  }
}

extension on Widget {
  Widget toBoxAdapter() {
    return SliverToBoxAdapter(child: this);
  }
}
