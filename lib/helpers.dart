import 'dart:async';

@pragma('vm:prefer-inline')
Future<void> yieldNow([Function()? callback]) {
  return Future.delayed(.zero, callback);
}

class RefCell<T> {
  T? _value;

  @pragma('vm:prefer-inline')
  T get value => _value!;
  @pragma('vm:prefer-inline')
  set value(T value) => _value = value;

  RefCell([this._value]);
}
