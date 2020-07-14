import 'package:flutter/foundation.dart';

import 'base_state.dart';

abstract class LoadableState extends BaseState {
  LoadableState() {
    fetch();
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
      await onFetch();
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

  Future<void> onFetch();
}
