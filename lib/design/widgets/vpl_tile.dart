import 'package:ikarus/design.dart';

enum VplTileType { sentinel, scope, assignment, ident, value, call }

class VplTile extends StatelessWidget {
  final VoidCallback? onTap;
  final VplTileType type;
  final Widget child;

  const VplTile({
    super.key,
    this.onTap,
    required this.type,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonBuilder(
      onTap: onTap,
      builder: (context, state, child) => Container(
        height: 48,
        padding: .symmetric(horizontal: 8),
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
      child: Row(
        children: [
          Container(
            width: 4,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: .circular(2),
              color: switch (type) {
                .sentinel => Colors.cSentinel1,
                .scope => Colors.cScope1,
                .assignment => Colors.cAssignment1,
                .ident => Colors.cIdent1,
                .value => Colors.cValue1,
                .call => Colors.cCall1,
              },
            ),
          ),
          Gap(16),
          Expanded(child: child),
        ],
      ),
    );
  }
}
