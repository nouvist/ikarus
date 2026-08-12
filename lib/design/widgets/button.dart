import 'package:ikarus/design.dart';

class Button extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onTapUp;
  final VoidCallback? onTapDown;
  final VoidCallback? onDoubleTap;
  final Widget child;

  const Button({
    super.key,
    this.onTap,
    this.onTapUp,
    this.onTapDown,
    this.onDoubleTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ButtonBuilder(
        onTap: onTap,
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        onDoubleTap: onDoubleTap,
        builder: (context, state, child) => DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: .circular(8),
            border: Border(
              bottom: .new(
                color: switch (state) {
                  .hover => Colors.brt,
                  _ => Colors.bro,
                },
                width: 2,
              ),
            ),
          ),
          child: DecoratedBox(
            decoration: switch (state) {
              .rest => BoxDecoration(
                color: Colors.ov1,
                border: .all(color: Colors.bro),
                borderRadius: .circular(8),
              ),
              .hover => BoxDecoration(
                color: Colors.ov2,
                border: .all(color: Colors.bro),
                borderRadius: .circular(8),
              ),
              .tap => BoxDecoration(
                color: Colors.ov0,
                border: .all(color: Colors.bro),
                borderRadius: .circular(8),
              ),
            },
            child: Foreground(
              color: switch (state) {
                .tap => Colors.fg1,
                _ => Colors.fg0,
              },
              child: child!,
            ),
          ),
        ),
        child: Center(
          child: Padding(padding: .symmetric(horizontal: 16), child: child),
        ),
      ),
    );
  }
}
