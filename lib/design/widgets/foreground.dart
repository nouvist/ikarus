import 'package:ikarus/design.dart';

class Foreground extends StatelessWidget {
  final double? size;
  final Color? color;
  final Widget child;

  const Foreground({super.key, this.size, this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: .new(color: color),
      child: IconTheme.merge(
        data: .new(color: color),
        child: child,
      ),
    );
  }
}
