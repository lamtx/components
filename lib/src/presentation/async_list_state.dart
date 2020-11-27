import 'package:flutter/foundation.dart';

import 'list_state.dart';
import 'list_state_ext.dart';

abstract class AsyncListState<T extends Object> extends ListState<T> {
  AsyncListState() {
    fetch();
  }

  bool _pendingFetch = false;

  @mustCallSuper
  Future<void> fetch() async {
    if (isLoading) {
      _pendingFetch = true;
      return;
    }
    clearAllItems();
    isLoading = true;
    _pendingFetch = false;
    try {
      addItems(await onFetch());
      notifyListeners();
      exception = null;
    } on Exception catch (e) {
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
