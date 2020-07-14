import 'predicate.dart';

extension Core<T> on T {
  T takeIf(Predicate<T> predicate) => predicate(this) ? this : null;

  R run<R>(R Function(T) block) => block(this);

  T also(void Function(T) block) {
    block(this);
    return this;
  }
}
