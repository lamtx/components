class Lazy<T> {
    Lazy(T Function() init) : _init = init;

    final T Function() _init;
    var _initialized = false;
    T _value;

    T call() {
        if (_initialized) {
            return _value;
        }
        _value = _init();
        _initialized = true;
        return _value;
    }

    bool get isInitialized => _initialized;
}