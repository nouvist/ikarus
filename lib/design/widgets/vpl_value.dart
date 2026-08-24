import 'package:ikarus/design.dart';

enum VplInnerType { ident, value }

class VplValue extends StatelessWidget {
  final VoidCallback? onTap;
  final VplInnerType type;
  final Widget child;

  const VplValue({
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
          child: Foreground(color: Colors.cFg1, child: child),
        ),
      ),
    );
  }
}

class VplValueWrapper extends StatelessWidget {
  final VoidCallback? onTap;
  final List<Widget> children;
  const VplValueWrapper({super.key, this.onTap, this.children = const []});

  @override
  Widget build(BuildContext context) {
    final parent = context.findAncestorWidgetOfExactType<VplValueWrapper>();

    return Container(
      decoration: switch (parent != null) {
        true => null,
        false => const BoxDecoration(
          color: Colors.fg0,
          borderRadius: .all(.circular(8)),
        ),
      },
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
          padding: switch (parent != null) {
            true => .zero,
            false => const .symmetric(horizontal: 6),
          },
          decoration: switch (parent != null) {
            true => null,
            false => BoxDecoration(
              color: Colors.bg0,
              borderRadius: const .all(.circular(6)),
              border: .all(color: Colors.bro),
            ),
          },
          child: IgnorePointer(
            child: Row(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: switch (parent != null) {
                false => children,
                true => [const Text('( '), ...children, const Text(' )')],
              },
            ),
          ),
        ),
      ),
    );
  }
}

enum VplInnerOperationType {
  add,
  subtract,
  multiply,
  divide,
  reminder,
  boolAnd,
  boolOr,
  boolEq,
  boolNe,
  boolLt,
  boolLe,
  boolGt,
  boolGe,
}

class VplInnerOperation extends StatelessWidget {
  final VoidCallback? onTap;
  final VplInnerOperationType type;
  final Widget child;

  const VplInnerOperation({
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
            color: Colors.cScope0,
            border: .all(color: Colors.cScope1),
            borderRadius: const .all(.circular(4)),
          ),
          child: child,
        ),
      ),
    );
  }
}
