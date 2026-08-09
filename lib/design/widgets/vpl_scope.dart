import 'package:flutter_svg/svg.dart';
import 'package:ikarus/design.dart';

class VplScopeStart extends StatelessWidget {
  final int? nested;
  final Widget child;

  const VplScopeStart({super.key, this.nested, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .only(
        left: (nested ?? VplNested.maybeOf(context) ?? 0) * 33,
        bottom: 1,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: SvgPicture.asset(
              colorFilter: .mode(Colors.cScope, .srcIn),
              'assets/paths/VplScopeStart.svg',
            ),
          ),
          Padding(
            padding: const .only(left: 66),
            child: IntrinsicWidth(
              child: Container(
                height: 48,
                padding: .only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: .horizontal(right: .circular(6)),
                  color: Colors.cScope,
                ),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VplScopeEnd extends StatelessWidget {
  final int? nested;

  const VplScopeEnd({super.key, this.nested});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .only(
        left: (nested ?? VplNested.maybeOf(context) ?? 0) * 33,
        bottom: 1,
      ),
      child: SizedBox(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Gap(48),
            Positioned(
              left: 0,
              bottom: -18,
              child: SvgPicture.asset(
                colorFilter: .mode(Colors.cScope, .srcIn),
                'assets/paths/VplScopeEnd.svg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
