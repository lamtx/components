import 'package:flutter/material.dart';

import '../../templates.dart';
import 'base_state.dart';

class ListState<T extends Object> extends BaseState {
  final GlobalKey<AnimatedAsyncListViewState<T>> listKey = GlobalKey();
  List<T> _items = [];

  List<T> get items => _items;

  set items(List<T> newValue) {
    _items = newValue;
    if (!isDisposed) {
      notifyListeners();
    }
  }
}
