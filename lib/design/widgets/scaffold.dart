import 'package:ikarus/design.dart';

class Scaffold extends SingleChildStatelessWidget {
  final EdgeInsets? padding;

  const Scaffold({super.key, this.padding, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Container(color: Colors.bg0, padding: padding, child: child!);
  }
}
