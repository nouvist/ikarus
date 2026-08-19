import 'package:ikarus/design.dart';

class ToggleButton extends StatelessWidget {
  final bool active;
  final VoidCallback? onTap;
  final VoidCallback? onTapUp;
  final VoidCallback? onTapDown;
  final VoidCallback? onDoubleTap;
  final double? width;
  final double? height;
  final EdgeInsets? padding;

  final Widget child;

  const ToggleButton({
    super.key,
    this.active = false,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.onDoubleTap,
    this.width,
    this.height,
    this.padding,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonBuilder(
      onTap: onTap,
      builder: (context, state, child) => Container(
        height: 48,
        alignment: .center,
        padding: const .symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: const .all(.circular(8)),
          border: switch (active) {
            true => .all(color: Colors.a0),
            false => .all(color: Colors.bg1),
          },
          color: switch (state) {
            .rest => Colors.ov0,
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
