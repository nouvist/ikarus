import 'package:ikarus/design.dart';
import 'package:ikarus/extensions.dart';

class ContextMenu extends StatefulWidget {
  final Offset? position;
  final List<ContextMenuItem> children;

  const ContextMenu({super.key, this.position, required this.children});

  @override
  State<ContextMenu> createState() => _ContextMenuState();
}

class _ContextMenuState extends State<ContextMenu> {
  final _controller = OverlayPortalController();
  late var _left = widget.position?.dx ?? 0;
  late var _top = widget.position?.dy ?? 0;

  @pragma('vm:prefer-inline')
  double _estimateWidth() => 128;

  @pragma('vm:prefer-inline')
  double _estimateHeight() => widget.children.length * 32 + 4 * 2;

  @override
  void initState() {
    super.initState();
    yieldNow(() {
      final overlay = context.findAncestorElement<Overlay>()!.size!;
      final height = _estimateHeight();
      final width = _estimateWidth();

      if (_left + width > overlay.width) _left -= width;
      if (_top + height > overlay.height) _top -= height;
      if (_left < 0) _left = 0;
      if (_top < 0) _top -= 0;
      _controller.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _controller,
      overlayChildBuilder: (context) => Positioned(
        left: _left,
        top: _top,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.bg1,
            border: .all(color: Colors.bro),
            borderRadius: .circular(8),
            boxShadow: [.new(color: Colors.bg0.withAlpha(128), blurRadius: 16)],
          ),
          child: Padding(
            padding: .all(4),
            child: IntrinsicWidth(
              child: Inherited<_ContextMenuState>(
                value: this,
                child: Column(
                  crossAxisAlignment: .stretch,
                  children: widget.children,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContextMenuItem extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;

  const ContextMenuItem({super.key, this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return ButtonBuilder(
      onTapDown: () {
        onTap?.call();
        Inherited.maybeOf<_ContextMenuState>(context)?._controller.hide();
      },
      builder: (context, state, child) => SizedBox(
        height: 32,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: .circular(4),
            color: switch (state) {
              .rest => Colors.tr,
              .hover => Colors.ov1,
              .tap => Colors.ov0,
            },
          ),
          child: Padding(
            padding: .symmetric(horizontal: 12),
            child: Foreground(
              color: switch (state) {
                .tap => Colors.fg1,
                _ => Colors.fg0,
              },
              child: Align(alignment: .centerLeft, child: child!),
            ),
          ),
        ),
      ),
      child: child,
    );
  }
}
