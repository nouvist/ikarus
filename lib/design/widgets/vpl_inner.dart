import 'package:ikarus/design.dart';

enum VplInnerType { ident, value }

class VplInner extends StatelessWidget {
  final VoidCallback? onTap;
  final VplInnerType type;
  final Widget child;

  const VplInner({
    super.key,
    this.onTap,
    required this.type,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: const BoxDecoration(
        color: Colors.fg0,
        borderRadius: .all(.circular(4)),
      ),
      child: ButtonBuilder(
        onTap: onTap,
        builder: (context, state, child) => Opacity(
          opacity: switch (state) {
            .rest => 1,
            .hover => 0.9,
            .tap => 0.95,
          },
          child: child!,
        ),
        child: Container(
          height: 32,
          padding: const .symmetric(horizontal: 8),
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
            borderRadius: const .all(.circular(4)),
          ),
          child: child,
        ),
      ),
    );
  }
}

class VplInnerWrapper extends StatelessWidget {
  final VoidCallback? onTap;
  final List<Widget> children;
  const VplInnerWrapper({super.key, this.onTap, this.children = const []});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.fg0,
        borderRadius: .all(.circular(6)),
      ),
      child: ButtonBuilder(
        onTap: onTap,
        builder: (context, state, child) => Opacity(
          opacity: switch (state) {
            .rest => 1,
            .hover => 0.9,
            .tap => 0.95,
          },
          child: child!,
        ),
        child: Container(
          height: 42,
          padding: const .symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.bg0,
            borderRadius: const .all(.circular(6)),
            border: .all(color: Colors.bro),
          ),
          child: IgnorePointer(child: Row(children: children)),
        ),
      ),
    );
  }
}
