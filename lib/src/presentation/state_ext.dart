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

  void addCancellable(Cancellable cancellable) {
    const key = "presentation:addSubscription";
    setTagIfAbsent(key, _SubscriptionCleaner.new).add(cancellable);
  }
}

class _SubscriptionCleaner implements Cancellable {
  final _values = <Object>[]; // StreamSubscription<void> or Cancellable

  void add(Object subscription) {
    assert(subscription is Cancellable ||
        subscription is StreamSubscription<void>);
    _values.add(subscription);
  }

  @override
  void cancel() {
    for (final value in _values) {
      if (value is Cancellable) {
        value.cancel();
      } else if (value is StreamSubscription<void>) {
        value.cancel();
      }
    }
  }
}
