import 'dart:async';

import 'package:cancellation/cancellation.dart';
import 'package:flutter/foundation.dart';

class BaseState with ChangeNotifier {
  bool _isDisposed = false;
  bool _isLoading = false;
  Exception? _exception;
  final Map<String, Object> _tags = {};

  bool get isLoading => _isLoading;

  set isLoading(bool newValue) {
    if (_isLoading != newValue) {
      _isLoading = newValue;
      if (!_isDisposed) {
        notifyListeners();
      }
    }
  }

  Exception? get exception => _exception;

  set exception(Exception? newValue) {
    _exception = newValue;
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  @protected
  bool get isDisposed => _isDisposed;

  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
    for (final tag in _tags.values) {
      _closeObject(tag);
    }
    _tags.clear();
  }

  T? getTag<T extends Object>(String key) {
    return _tags[key] as T?;
  }

  T setTagIfAbsent<T extends Object>(String key, T Function() newValue) {
    final previous = _tags[key] as T?;
    if (previous == null) {
      final value = newValue();
      _tags[key] = value;
      return value;
    } else {
      return previous;
    }
  }

  static void _closeObject(Object object) {
    if (object is Cancellable) {
      object.cancel();
    } else if (object is StreamSubscription<void>) {
      object.cancel();
    }
  }
}
