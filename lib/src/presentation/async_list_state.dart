import 'package:ext/ext.dart';
import 'package:flutter/foundation.dart';

import 'list_state.dart';
import 'list_state_ext.dart';

abstract base class AsyncListState<T extends Object> extends ListState<T> {
  AsyncListState({bool fetchNow = true}) {
    if (fetchNow) {
      fetch();
    }
  }

  bool _pendingFetch = false;

  @mustCallSuper
  Future<void> fetch() async {
    if (isLoading) {
      _pendingFetch = true;
      return;
    }
    isLoading = true;
    _pendingFetch = false;
    try {
      final newItems = await onFetch();
      clearAllItems();
      addItems(newItems);
      notifyListeners();
      exception = null;
    } on Exception catch (e) {
      assert(log("AsyncList", "fetch failed", e));
      clearAllItems();
      exception = e;
    } finally {
      isLoading = false;
    }

    if (_pendingFetch) {
      final _ = fetch();
    }
  }

  Future<List<T>> onFetch();
}
