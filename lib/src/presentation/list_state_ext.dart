import 'package:ext/ext.dart';

import 'list_state.dart';

extension ListStateExt<T extends Object> on ListState<T> {
  void addItem(T item) {
    listKey.currentState?.insertItem(items.length);
    items.add(item);
  }

  void removeItemAt(int index) {
    listKey.currentState?.removeItem(index);
    items.removeAt(index);
  }

  void removeItemInRange(int start, int end) {
    final state = listKey.currentState;
    if (state != null) {
      for (var i = start; i < end; i++) {
        state.removeItem(i);
      }
    }
    items.removeRange(start, end);
  }

  bool removeFirstItem(Predicate<T> where) {
    final index = items.indexWhere(where);
    if (index != -1) {
      removeItemAt(index);
    }
    return index != -1;
  }

  bool removeItem(T item) {
    final index = items.indexOf(item);
    if (index != -1) {
      removeItemAt(index);
    }
    return index != -1;
  }

  void removeLastItem() {
    removeItemAt(items.length - 1);
  }

  void detectChanges(List<T> newItems, DetectChanges what) {
    final oldItems = items;
    assert(!identical(oldItems, newItems),
        "detecting changes from same collection looks like an error");
    if (oldItems.isEmpty || newItems.isEmpty) {
      setItems(newItems);
      return;
    }
    final state = listKey.currentState;
    if (state == null) {
      items = newItems;
      return;
    }
    var changed = 0;
    if (what == DetectChanges.onlyDeleteNoMove) {
      assert(newItems.length < oldItems.length);
      for (var i = 0, newIndex = 0; i < oldItems.length; i++) {
        if (oldItems[i] == newItems[newIndex]) {
          newIndex += 1;
          continue;
        }
        changed -= 1;
        state.removeItem(i);
      }
    } else if (what == DetectChanges.onlyInsertNoMove) {
      assert(newItems.length > oldItems.length);
      for (var i = 0, newIndex = 0; newIndex < newItems.length; newIndex++) {
        if (oldItems[i] == newItems[newIndex]) {
          i++;
          continue;
        }
        changed += 1;
        state.insertItem(i);
      }
    }
    assert(oldItems.length + changed == newItems.length);
    items = newItems;
  }

  void setItems(List<T> newItems) {
    assert(!identical(items, newItems),
        "set items from original collection looks like an error");
    final state = listKey.currentState;
    if (state != null) {
      final diff = newItems.length - items.length;

      if (diff > 0) {
        for (var i = 0; i < diff; i++) {
          state.insertItem(items.length + i);
        }
      } else if (diff < 0) {
        for (var i = 0; i > diff; i--) {
          state.removeItem(items.length + i - 1);
        }
      }
      state.disableAnimation();
    }
    items = newItems;
  }

  void addItems(List<T> newItems) {
    final state = listKey.currentState;
    if (state != null) {
      final diff = newItems.length;
      for (var i = 0; i < diff; i++) {
        state.insertItem(items.length + i);
      }
      state.disableAnimation();
    }
    items.addAll(newItems);
  }

  void clearAllItems() {
    final state = listKey.currentState;
    if (state != null) {
      final diff = -items.length;
      for (var i = 0; i > diff; i--) {
        state.removeItem(items.length + i - 1);
      }
      state.disableAnimation();
    }
    items = [];
  }
}

enum DetectChanges { onlyInsertNoMove, onlyDeleteNoMove }
