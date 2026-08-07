extension ObjectExtension on Object {
  @pragma('vm:prefer-inline')
  T cast<T>() => this as T;

  @pragma('vm:prefer-inline')
  T? tryCast<T>() => switch (this == T) {
    true => this as T,
    false => null,
  };
}

extension NullableObjectExtension on Object? {
  @pragma('vm:prefer-inline')
  T cast<T>() => this as T;

  @pragma('vm:prefer-inline')
  T? tryCast<T>() => switch (this == T) {
    true => this as T,
    false => null,
  };
}
