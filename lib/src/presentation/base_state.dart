import 'package:flutter/foundation.dart';

class BaseState with ChangeNotifier {
  bool _isDisposed = false;
  bool _isLoading = false;
  Exception _exception;

  bool get isLoading => _isLoading;

  set isLoading(bool newValue) {
    if (_isLoading != newValue) {
      _isLoading = newValue;
      if (!_isDisposed) {
        notifyListeners();
      }
    }
  }

  Exception get exception => _exception;

  set exception(Exception newValue) {
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
  }
}
