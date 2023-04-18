import 'package:ext/ext.dart';
import 'package:flutter/material.dart';

import 'async_list_state.dart';
import 'list_state_ext.dart';

abstract class PaginatedListState<T extends Object> extends AsyncListState<T> {
  PaginatedListState({super.fetchNow = true});

  final keywordController = TextEditingController();
  var _canNext = true;
  var _pageIndex = 0;

  String get keyword => keywordController.text;

  int get pageIndex => _pageIndex;

  void fetchMore() async {
    if (isLoading || !_canNext) {
      return;
    }
    isLoading = true;
    _pageIndex += 1;
    try {
      final elements = await onFetch();
      addItems(elements);
      exception = null;
      _canNext = elements.isNotEmpty;
    } on Exception catch (e) {
      assert(log("AsyncList", "fetch failed", e));
      exception = e;
    } finally {
      isLoading = false;
    }
  }

  @override
  Future<void> fetch() {
    _canNext = true;
    _pageIndex = 0;
    return super.fetch();
  }
}
