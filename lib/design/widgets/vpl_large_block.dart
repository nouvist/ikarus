import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ikarus/design.dart';

typedef VplLargeBlockType = VplBlockType;

class VplLargeBlock extends StatefulWidget {
  final VoidCallback? onDelete;
  final VoidCallback? onDuplicate;
  final int? nested;
  final VplLargeBlockType type;
  final Widget child;

  const VplLargeBlock({
    super.key,
    this.onDelete,
    this.onDuplicate,
    this.nested,
    required this.type,
    required this.child,
  });

  @override
  State<VplLargeBlock> createState() => _VplLargeBlockState();
}

class _VplLargeBlockState extends State<VplLargeBlock> {
  var _isShowControls = false;

  void _handleMouseEnter(PointerEnterEvent event) {
    setState(() {
      _isShowControls = true;
    });
  }

  void _handleMouseExit(PointerExitEvent event) {
    setState(() {
      _isShowControls = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = switch (widget.type) {
      .sentinel => Colors.cStart0,
      .variable => Colors.cVariable0,
      .call => Colors.cCall0,
      .ident => Colors.cIdent0,
    };

    return MouseRegion(
      onEnter: _handleMouseEnter,
      onExit: _handleMouseExit,
      child: Padding(
        padding: .only(
          left: (widget.nested ?? VplNested.maybeOf(context) ?? 0) * 33,
          bottom: 1,
        ),
        child: Stack(
          clipBehavior: .none,
          children: [
            Padding(
              padding: const .only(left: 68),
              child: IntrinsicWidth(
                child: Row(
                  children: [
                    Container(
                      constraints: const .new(minHeight: 48),
                      padding: const .only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: .horizontal(right: const .circular(6)),
                        color: color,
                      ),
                      child: Foreground(
                        color: Colors.cFg0,
                        child: Padding(
                          padding: const .symmetric(vertical: 8),
                          child: widget.child,
                        ),
                      ),
                    ),
                    if (_isShowControls && widget.type != .sentinel) ...[
                      const Gap(16),
                      VplControls(
                        onDelete: widget.onDelete,
                        onDuplicate: widget.onDuplicate,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: -18,
              child: SvgPicture.asset(
                colorFilter: .mode(color, .srcIn),
                'assets/paths/VplBoth.svg',
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: SvgPicture.asset(
                colorFilter: .mode(color, .srcIn),
                'assets/paths/VplBoth.svg',
              ),
            ),
            Positioned(
              left: 0,
              top: 18,
              bottom: 8,
              width: 68,
              child: ColoredBox(color: color)),
          ],
        ),
      ),
    );
  }
}
