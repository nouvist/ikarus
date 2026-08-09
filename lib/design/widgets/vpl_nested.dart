import 'package:ikarus/design.dart';

class VplNested extends InheritedWidget {
  final int value;

  const VplNested({super.key, required this.value, required super.child});

  static int? maybeOf(BuildContext context) {
    return context.getInheritedWidgetOfExactType<VplNested>()?.value;
  }

  static int of(BuildContext context) {
    return maybeOf(context)!;
  }

  @override
  bool updateShouldNotify(VplNested oldWidget) {
    return true;
  }
}
