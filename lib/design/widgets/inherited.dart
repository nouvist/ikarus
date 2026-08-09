import 'package:ikarus/design.dart';

class Inherited<T> extends InheritedWidget {
  final T value;

  const Inherited({super.key, required super.child, required this.value});

  @pragma('vm:prefer-inline')
  static T? maybeOf<T>(BuildContext context) {
    return context.getInheritedWidgetOfExactType<Inherited<T>>()?.value;
  }

  @pragma('vm:prefer-inline')
  static T of<T>(BuildContext context) {
    return maybeOf(context)!;
  }

  @override
  bool updateShouldNotify(covariant Inherited<T> oldWidget) {
    return oldWidget.value != value;
  }
}
