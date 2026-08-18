import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ikarus/design.dart';

class VplScopeStart extends StatefulWidget {
  final VoidCallback? onDelete;
  final VoidCallback? onDuplicate;
  final int? nested;
  final Widget child;

  const VplScopeStart({
    super.key,
    this.onDelete,
    this.onDuplicate,
    this.nested,
    required this.child,
  });

  @override
  State<VplScopeStart> createState() => _VplScopeStartState();
}

class _VplScopeStartState extends State<VplScopeStart> {
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
            Positioned(
              left: 0,
              top: 0,
              child: SvgPicture.asset(
                colorFilter: const .mode(Colors.cScope0, .srcIn),
                'assets/paths/VplScopeStart.svg',
              ),
            ),
            Padding(
              padding: const .only(left: 66),
              child: IntrinsicWidth(
                child: Row(
                  children: [
                    Container(
                      height: 48,
                      padding: const .only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: .horizontal(right: const .circular(6)),
                        color: Colors.cScope0,
                      ),
                      child: widget.child,
                    ),
                    if (_isShowControls) ...[
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
          ],
        ),
      ),
    );
  }
}

class VplScopeEnd extends StatefulWidget {
  final VoidCallback? onDelete;
  final VoidCallback? onDuplicate;
  final int? nested;

  const VplScopeEnd({super.key, this.onDelete, this.onDuplicate, this.nested});

  @override
  State<VplScopeEnd> createState() => _VplScopeEndState();
}

class _VplScopeEndState extends State<VplScopeEnd> {
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
            Positioned(
              left: 0,
              top: 0,
              child: Row(
                children: [
                  SvgPicture.asset(
                    colorFilter: const .mode(Colors.cScope0, .srcIn),
                    'assets/paths/VplScopeEnd.svg',
                  ),
                  if (_isShowControls) ...[
                    const Gap(16),
                    Transform.translate(
                      offset: const Offset(0, -10),
                      child: VplControls(
                        onDelete: widget.onDelete,
                        onDuplicate: widget.onDuplicate,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 128, height: 48),
          ],
        ),
      ),
    );
  }
}
