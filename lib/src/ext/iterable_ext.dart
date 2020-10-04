import 'pair.dart';
import 'predicate.dart';

extension IterableExt<T> on Iterable<T> {
  bool get isNullOrEmpty {
    return this == null || isEmpty;
  }

  double sumByDouble(double Function(T) transform) {
    var value = 0.0;
    for (final item in this) {
      value += transform(item);
    }
    return value;
  }

  int sumByInt(int Function(T e) transform) {
    var value = 0;
    for (final item in this) {
      value += transform(item);
    }
    return value;
  }

  int countBy(bool Function(T e) predicate) {
    var count = 0;
    for (final e in this) {
      if (predicate(e)) {
        count += 1;
      }
    }
    return count;
  }

  List<T> added(T newItem) {
    final list = List<T>(length + 1);
    var i = 0;
    for (final e in this) {
      list[i++] = e;
    }
    list.last = newItem;
    return list;
  }

  T firstOrNull([bool Function(T e) predicate]) {
    if (predicate == null) {
      return isEmpty ? null : first;
    }
    return firstWhere(predicate, orElse: () => null);
  }

  T lastOrNull([bool Function(T e) predicate]) {
    if (predicate == null) {
      return isEmpty ? null : last;
    }
    return lastWhere(predicate, orElse: () => null);
  }

  Map<K, V> associate<K, V>(Pair<K, V> Function(T e) transform) {
    final result = <K, V>{};
    for (final e in this) {
      final r = transform(e);
      result[r.first] = r.second;
    }
    return result;
  }

  List<R> flatten<R>(List<R> Function(T element) transform) {
    final result = <R>[];
    for (final element in this) {
      result.addAll(transform(element));
    }
    return result;
  }

  List<R> mapNotNull<R>(R Function(T e) transform) {
    final result = <R>[];
    for (final e in this) {
      final t = transform(e);
      if (t != null) {
        result.add(t);
      }
    }
    return result;
  }

  List<T> filterNotNull() {
    final result = <T>[];
    for (final e in this) {
      if (e != null) {
        result.add(e);
      }
    }
    return result;
  }

  List<R> filterIsInstance<R>() {
    final result = <R>[];
    for (final e in this) {
      if (e is R) {
        result.add(e);
      }
    }
    return result;
  }

  List<T> filter(Predicate<T> predicate) {
    final result = <T>[];
    for (final e in this) {
      if (predicate(e)) {
        result.add(e);
      }
    }
    return result;
  }

  List<T> filterNot(Predicate<T> predicate) {
    final result = <T>[];
    for (final e in this) {
      if (!predicate(e)) {
        result.add(e);
      }
    }
    return result;
  }

  String joinToString([
    String separator = ", ",
    String Function(T e) transform,
  ]) {
    final iterator = this.iterator;
    transform ??= (e) => e.toString();
    if (!iterator.moveNext()) {
      return "";
    }
    final buffer = StringBuffer();
    if (separator == null || separator == "") {
      do {
        buffer.write(transform(iterator.current));
      } while (iterator.moveNext());
    } else {
      buffer.write(transform(iterator.current));
      while (iterator.moveNext()) {
        buffer.write(separator);
        buffer.write(transform(iterator.current));
      }
    }
    return buffer.toString();
  }

  Map<R, List<T>> groupBy<R>(R Function(T element) key) {
    final map = <R, List<T>>{};
    for (final element in this) {
      final list = map.putIfAbsent(key(element), () => []);
      list.add(element);
    }
    return map;
  }

  T maxBy<R extends Comparable<R>>(R Function(T element) selector) {
    if (isEmpty) {
      return null;
    }
    var value = selector(first);
    T element;
    for (final e in this) {
      final tmp = selector(e);
      if (tmp.compareTo(value) > 0) {
        value = tmp;
        element = e;
      }
    }
    return element;
  }
}
