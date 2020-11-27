import 'package:flutter/material.dart';

import '../../components.dart';
import 'empty_info.dart';
import 'exception_info.dart';
import 'loading_info.dart';
import 'safe_padding.dart';

class AnimatedAsyncListView<T extends Object> extends StatefulWidget {
  const AnimatedAsyncListView({
    required this.items,
    Key? key,
    required this.itemBuilder,
    this.exception,
    this.emptyInfo = const EmptyInfo(),
    this.isLoading = false,
    this.padding,
    this.onLoadMore,
    this.reverse = false,
    this.onRefresh,
  }) : super(key: key);

  final bool isLoading;
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Exception? exception;
  final Widget? emptyInfo;
  final EdgeInsets? padding;

  final VoidCallback? onLoadMore;
  final bool reverse;
  final RefreshCallback? onRefresh;

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
      return const LoadingInfo();
    }
    Widget listView = AnimatedList(
      padding: widget.padding ?? safePaddingVertical(context),
      key: _listKey,
      initialItemCount: widget.items.length,
      reverse: widget.reverse,
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
            ExceptionInfo(widget.exception!)
          else if (widget.emptyInfo != null)
            widget.emptyInfo!,
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
