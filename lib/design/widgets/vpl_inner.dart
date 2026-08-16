import 'package:ikarus/design.dart';

enum VplInnerType { ident, value }

class VplInner extends StatelessWidget {
  final VplInnerType type;
  final Widget child;

  const VplInner({super.key, required this.type, required this.child});

  @override
  Widget build(BuildContext context) {
    return ButtonBuilder(
      builder: (context, state, child) => Opacity(
        opacity: switch (state) {
          .rest => 1,
          .hover => 0.9,
          .tap => 0.8,
        },
        child: child!,
      ),
      child: Container(
        height: 32,
        padding: .symmetric(horizontal: 8),
        alignment: .center,
        decoration: BoxDecoration(
          color: switch (type) {
            .ident => Colors.cIdent0,
            .value => Colors.cValue0,
          },
          border: .all(
            color: switch (type) {
              .ident => Colors.cIdent1,
              .value => Colors.cValue1,
            },
          ),
          borderRadius: .circular(4),
        ),
        child: child,
      ),
    );
  }
}
