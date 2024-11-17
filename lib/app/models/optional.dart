class Optional<T> {
  final T? _value;

  Optional._(this._value);

  /// Factory constructor to create an Optional with a value.
  static Optional<T> of<T>(T value) => Optional._(value);

  /// Factory constructor to create an empty Optional.
  static Optional<T> empty<T>() => Optional._(null);

  /// Checks if the value is present.
  bool get isPresent => _value != null;

  /// Returns the value if present, otherwise throws an exception.
  T get value {
    if (_value == null) {
      throw StateError("No value present");
    }
    return _value;
  }

  /// Returns the value if present, otherwise returns the [other] value.
  T orElse(T other) => _value ?? other;

  /// Returns the value if present, otherwise executes [other] and returns the result.
  T orElseGet(T Function() other) => _value ?? other();

  /// Executes [action] if the value is present.
  void ifPresent(void Function(T) action) {
    if (_value != null) {
      action(_value);
    }
  }

  /// Maps the value if present using [mapper], otherwise returns an empty Optional.
  Optional<U> map<U>(U Function(T) mapper) {
    if (_value == null) return Optional.empty();
    return Optional.of(mapper(_value));
  }

  @override
  String toString() => isPresent ? 'Optional($value)' : 'Optional.empty';
}
