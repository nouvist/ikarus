import 'package:ikarus/design.dart';

enum VplIndicatorType { editing, running, selected }

class VplIndicator extends StatelessWidget {
  final VplIndicatorType type;
  final Widget child;

  const VplIndicator({super.key, this.type = .editing, required this.child});

  @override
  Widget build(BuildContext context) {
    if (type == .editing) return child;
    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: switch (type) {
              .editing || .running => null,
              .selected => const Align(
                alignment: .centerLeft,
                child: Icon(FluentIcons.chevron_right_24_regular),
              ),
            },
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
