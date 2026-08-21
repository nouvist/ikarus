import 'package:ikarus/design.dart';

class Scaffold extends SingleChildStatelessWidget {
  final Titlebar? titlebar;
  final EdgeInsets? padding;

  const Scaffold({
    super.key,
    super.child,
    this.titlebar,
    this.padding,
  });

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Container(
      color: Colors.bg0,
      padding: padding,
      child: Column(
        children: [
          ?titlebar,
          Expanded(child: child!),
        ],
      ),
    );
  }
}
