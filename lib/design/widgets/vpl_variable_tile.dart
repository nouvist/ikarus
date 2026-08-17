import 'package:ikarus/design.dart';

class VplVariableTile extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;

  const VplVariableTile({super.key, this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return ButtonBuilder(
      onTap: onTap,
      builder: (context, state, child) => Container(
        height: 48,
        alignment: .centerLeft,
        padding: .symmetric(horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: .circular(8),
          color: switch (state) {
            .rest => null,
            .hover => Colors.ov1,
            .tap => Colors.ov2,
          },
        ),
        child: Foreground(
          color: switch (state) {
            .hover => Colors.fg0,
            _ => Colors.fg1,
          },
          child: child!,
        ),
      ),
      child: child,
    );
  }
}
