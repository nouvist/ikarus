import 'package:ikarus/design.dart';

class Scaffold extends SingleChildStatelessWidget {
  final Titlebar? titlebar;
  final EdgeInsets? padding;

  const Scaffold({super.key, super.child, this.titlebar, this.padding});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return ColoredBox(
      color: Colors.bg0,
      child: Column(
        children: [
          ?titlebar,
          Expanded(
            child: Padding(padding: padding ?? .zero, child: child!),
          ),
        ],
      ),
    );
  }
}
