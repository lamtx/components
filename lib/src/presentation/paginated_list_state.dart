import 'package:flutter/material.dart';

import 'async_list_state.dart';
import 'list_state_ext.dart';

abstract class PaginatedListState<T extends Object> extends AsyncListState<T> {
  PaginatedListState({super.fetchNow = true}) {
    keywordController.addListener(_onKeywordChanged);
  }

  final keywordController = TextEditingController();
  var _isEmptyKeyword = true;
  var _canNext = true;
  var _pageIndex = 0;

  bool get isEmptyKeyword => _isEmptyKeyword;

  String get keyword => keywordController.text;

  int get pageIndex => _pageIndex;

  set isEmptyKeyword(bool newValue) {
    if (_isEmptyKeyword != newValue) {
      _isEmptyKeyword = newValue;
      notifyListeners();
    }
  }

  void _onKeywordChanged() {
    isEmptyKeyword = keywordController.text.isEmpty;
  }

  @override
  void dispose() {
    keywordController.removeListener(_onKeywordChanged);
    super.dispose();
  }

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
