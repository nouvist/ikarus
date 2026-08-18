import 'package:ikarus/design.dart';

class VplVariable extends StatelessWidget {
  final VoidCallback? onTap;

  const VplVariable({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ButtonBuilder(
      onTap: onTap,
      builder: (context, state, child) => Container(
        height: 32,
        alignment: .center,
        padding: const .symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: const .all(.circular(8)),
          border: .all(color: Colors.brt),
          color: switch (state) {
            .rest => Colors.ov1,
            .hover => Colors.ov2,
            .tap => null,
          },
        ),
        child: Foreground(
          color: Colors.fg0,
          child: DefaultTextStyle.merge(
            style: const .new(fontWeight: .bold),
            child: const Text('...'),
          ),
        ),
      ),
    );
  }
}
