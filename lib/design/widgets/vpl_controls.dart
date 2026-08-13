import 'package:ikarus/design.dart';

class VplControls extends StatelessWidget {
  const VplControls({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Row(
        spacing: 8,
        children: [
          Button(
            width: 48,
            height: 48,
            padding: .zero,
            child: Icon(FluentIcons.delete_24_regular),
          ),
          Button(
            width: 48,
            height: 48,
            padding: .zero,
            child: Icon(FluentIcons.copy_24_regular),
          ),
        ],
      ),
    );
  }
}
