import 'dart:async';

import 'package:cancellation/cancellation.dart';

import 'base_state.dart';

extension StateExt on BaseState {
  CancellationTokenSource get cancellationTokenSource {
    const key = "presentation:cancellationTokenSource";
    return setTagIfAbsent(key, CancellationTokenSource.new);
  }

  void addSubscription(StreamSubscription<void> subscription) {
    const key = "presentation:addSubscription";
    setTagIfAbsent(key, _SubscriptionCleaner.new).add(subscription);
  }
}

class _SubscriptionCleaner implements Cancellable {
  final _values = <StreamSubscription<void>>[];

  void add(StreamSubscription<void> subscription) {
    _values.add(subscription);
  }

  @override
  void cancel() {
    for (final value in _values) {
      value.cancel();
    }
  }
}
