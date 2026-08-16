import 'package:ikarus/design.dart';

class VplControls extends StatelessWidget {
  final VoidCallback? onDelete;
  final VoidCallback? onDuplicate;

  const VplControls({super.key, this.onDelete, this.onDuplicate});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Row(
        spacing: 8,
        children: [
          _Button(onTap: onDelete, child: Icon(FluentIcons.delete_24_regular)),
          _Button(onTap: onDuplicate, child: Icon(FluentIcons.copy_24_regular)),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;

  const _Button({this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: ClipRRect(
        borderRadius: .circular(8),
        child: BackdropFilter(
          filter: .blur(sigmaX: 8, sigmaY: 8),
          child: Button(
            onTap: onTap,
            padding: .zero,
            width: 48,
            height: 48,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
