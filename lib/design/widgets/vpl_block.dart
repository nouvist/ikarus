import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ikarus/design.dart';

enum VplBlockCutout { both, start }

enum VplBlockType { sentinel, variable, call, ident }

class VplBlock extends StatefulWidget {
  final VoidCallback? onDelete;
  final VoidCallback? onDuplicate;
  final int? nested;
  final VplBlockCutout cutout;
  final VplBlockType type;
  final Widget child;

  const VplBlock({
    super.key,
    this.onDelete,
    this.onDuplicate,
    this.nested,
    required this.type,
    this.cutout = .both,
    required this.child,
  });

  @override
  State<VplBlock> createState() => _VplBlockState();
}

class _VplBlockState extends State<VplBlock> {
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
                      height: 48,
                      padding: const .only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: .horizontal(right: const .circular(6)),
                        color: color,
                      ),
                      child: Foreground(
                        color: Colors.cFg0,
                        child: widget.child,
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
              top: 0,
              child: SvgPicture.asset(
                colorFilter: .mode(color, .srcIn),
                switch (widget.cutout) {
                  .both => 'assets/paths/VplBoth.svg',
                  .start => 'assets/paths/VplStart.svg',
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
