import 'package:ikarus/design.dart';

class Button extends StatelessWidget {
  final Widget child;

  const Button({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ButtonBuilder(
        builder: (context, state, child) => DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: .circular(8),
            border: Border(
              bottom: .new(color: switch (state) {
                .hover => Colors.fg0.withAlpha(128),
                _ => Colors.border,
              }, width: 2),
            ),
          ),
          child: DecoratedBox(
            decoration: switch (state) {
              .rest => BoxDecoration(
                color: Colors.fg0.withAlpha(16),
                border: .all(color: Colors.border),
                borderRadius: .circular(8),
              ),
              .hover => BoxDecoration(
                color: Colors.fg0.withAlpha(24),
                border: .all(color: Colors.border),
                borderRadius: .circular(8),
              ),
              .tap => BoxDecoration(
                color: Colors.fg0.withAlpha(8),
                border: .all(color: Colors.border),
                borderRadius: .circular(8),
              ),
            },
            child: child!,
          ),
        ),
        child: Center(
          child: Padding(padding: .symmetric(horizontal: 16), child: child),
        ),
      ),
    );
  }
}
