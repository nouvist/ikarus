import 'package:ikarus/design.dart';

class Scaffold extends SingleChildStatelessWidget {
  const Scaffold({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Container(color: Colors.bg, child: child!);
  }
}
