import 'package:flutter/src/gestures/events.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ikarus/design.dart';

enum VplBlockCutout { both, start }

enum VplBlockType { start, assignment, call, ident, value }

class VplBlock extends StatefulWidget {
  final int? nested;
  final VplBlockCutout cutout;
  final VplBlockType type;
  final Widget child;

  const VplBlock({
    super.key,
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
      .start => Colors.cStart,
      .assignment => Colors.cAssignment,
      .call => Colors.cCall,
      .ident => Colors.cIdent,
      .value => Colors.cValue,
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
                      padding: .only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: .horizontal(right: .circular(6)),
                        color: color,
                      ),
                      child: widget.child,
                    ),
                    if (_isShowControls && widget.type != .start) ...[
                      Gap(16),
                      VplControls(),
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
