import 'dart:async';

import 'package:cancellation/cancellation.dart';
import 'package:flutter/foundation.dart';

import 'base_state.dart';

extension StateExt on BaseState {
  static const _tag = "presentation:addSubscription";

  CancellationTokenSource get cancellationTokenSource {
    const key = "presentation:cancellationTokenSource";
    return setTagIfAbsent(key, CancellationTokenSource.new);
  }

  void addSubscription(StreamSubscription<void> subscription) {
    setTagIfAbsent(_tag, _SubscriptionCleaner.new).add(subscription);
  }

  void addCancellable(Cancellable cancellable) {
    setTagIfAbsent(_tag, _SubscriptionCleaner.new).add(cancellable);
  }

  void addListener(Listenable listenable, VoidCallback listener) {
    listenable.addListener(listener);
    setTagIfAbsent(_tag, _SubscriptionCleaner.new)
        .add(_ListenableUnregister(listenable, listener));
  }

  void listen<T>(
    Stream<T> stream,
    void Function(T event) onEvent, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    addSubscription(stream.listen(
      onEvent,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    ));
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
    _values.clear();
  }
}

class _ListenableUnregister implements Cancellable {
  _ListenableUnregister(this.listenable, this.listener);

  final Listenable listenable;
  final VoidCallback listener;

  @override
  void cancel() {
    listenable.removeListener(listener);
  }
}
