import 'package:ikarus/design.dart';

enum VplTileType { sentinel, scope, assignment, ident, value, call }

class VplTile extends StatelessWidget {
  final VoidCallback? onTap;
  final VplTileType type;
  final Widget icon;
  final Widget child;

  const VplTile({
    super.key,
    this.onTap,
    required this.type,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonBuilder(
      onTap: onTap,
      builder: (context, state, child) => Container(
        height: 48,
        padding: const .symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: const .all(.circular(8)),
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
        spacing: 8,
        children: [
          Foreground(
            color: switch (type) {
              .sentinel => Colors.cStart1,
              .scope => Colors.cScope1,
              .assignment => Colors.cVariable1,
              .ident => Colors.cIdent1,
              .value => Colors.cValue1,
              .call => Colors.cNamespace1,
            },
            child: icon,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
