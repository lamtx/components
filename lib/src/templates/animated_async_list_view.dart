import 'package:flutter/material.dart';

import '../../components2.dart';
import 'safe_padding.dart';
import 'utilities.dart';

class AnimatedAsyncListView<T extends Object> extends StatefulWidget {
  const AnimatedAsyncListView({
    required this.items,
    required this.itemBuilder,
    this.exception,
    this.emptyInfoBuilder = defaultEmptyBuilder,
    this.loadingInfoBuilder = defaultLoadingBuilder,
    this.exceptionBuilder = defaultExceptionBuilder,
    this.isLoading = false,
    this.padding,
    this.onLoadMore,
    this.reverse = false,
    this.onRefresh,
    this.controller,
    super.key,
  });

  final bool isLoading;
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Exception? exception;
  final ExceptionWidgetBuilder exceptionBuilder;
  final WidgetBuilder emptyInfoBuilder;
  final WidgetBuilder loadingInfoBuilder;
  final EdgeInsets? padding;

  final VoidCallback? onLoadMore;
  final bool reverse;
  final RefreshCallback? onRefresh;
  final ScrollController? controller;

  @override
  AnimatedAsyncListViewState<T> createState() =>
      AnimatedAsyncListViewState<T>();
}

class AnimatedAsyncListViewState<T extends Object>
    extends State<AnimatedAsyncListView<T>> {
  final _listKey = GlobalKey<AnimatedListState>();
  bool _disableAnimation = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading && widget.items.isEmpty) {
      return widget.loadingInfoBuilder(context);
    }
    Widget listView = AnimatedList(
      padding: widget.padding ?? safePaddingVertical(context),
      key: _listKey,
      initialItemCount: widget.items.length,
      reverse: widget.reverse,
      controller: widget.controller,
      itemBuilder: (context, index, animation) {
        final item = widget.items[index];
        if (_disableAnimation) {
          return Container(
            key: ObjectKey(item),
            child: widget.itemBuilder(context, item),
          );
        }
        return FadeSlideTransition(
          key: ObjectKey(item),
          sizeFactor: animation,
          child: widget.itemBuilder(context, item),
        );
      },
    );
    if (widget.onRefresh != null) {
      listView = RefreshIndicator(
        onRefresh: widget.onRefresh!,
        child: listView,
      );
    }
    final child = widget.onLoadMore == null
        ? listView
        : NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 22) {
                if (widget.items.isNotEmpty) {
                  widget.onLoadMore!();
                }
              }
              return false;
            },
            child: Column(
              children: <Widget>[
                if (widget.reverse)
                  FixedHeightProgressIndicator(
                    isLoading: widget.items.isNotEmpty && widget.isLoading,
                  ),
                Expanded(
                  child: listView,
                ),
                if (!widget.reverse)
                  FixedHeightProgressIndicator(
                    isLoading: widget.items.isNotEmpty && widget.isLoading,
                  )
              ],
            ),
          );

    if (widget.items.isEmpty) {
      return Stack(
        children: <Widget>[
          child,
          if (widget.exception != null)
            widget.exceptionBuilder(context, widget.exception!)
          else
            widget.emptyInfoBuilder(context),
        ],
      );
    } else {
      return child;
    }
  }

  void disableAnimation() {
    _disableAnimation = true;
  }

  void insertItem(int index) {
    _disableAnimation = false;
    _listKey.currentState?.insertItem(index);
  }

  void removeItem(int index) {
    _disableAnimation = false;
    _listKey.currentState
        ?.removeItem(index, _childBuilder(widget.items[index]));
  }

  AnimatedListRemovedItemBuilder _childBuilder(T item) {
    return (context, animation) => FadeSlideTransition(
          sizeFactor: animation,
          child: widget.itemBuilder(context, item),
        );
  }
}
