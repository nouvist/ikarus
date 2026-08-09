import 'package:flutter_svg/svg.dart';
import 'package:ikarus/design.dart';

enum VplBlockCutout { both, start }

enum VplBlockType { start, assignment, call, ident, value }

class VplBlock extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final color = switch (type) {
      .start => Colors.cStart,
      .assignment => Colors.cAssignment,
      .call => Colors.cCall,
      .ident => Colors.cIdent,
      .value => Colors.cValue,
    };

    return Padding(
      padding: .only(
        left: (nested ?? VplNested.maybeOf(context) ?? 0) * 33,
        bottom: 1,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const .only(left: 68),
            child: IntrinsicWidth(
              child: Container(
                height: 48,
                padding: .only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: .horizontal(right: .circular(6)),
                  color: color,
                ),
                child: child,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: SvgPicture.asset(
              colorFilter: .mode(color, .srcIn),
              switch (cutout) {
                .both => 'assets/paths/VplBoth.svg',
                .start => 'assets/paths/VplStart.svg',
              },
            ),
          ),
        ],
      ),
    );
  }
}

class VplNewBlock extends StatelessWidget {
  final int? nested;

  const VplNewBlock({super.key, this.nested});

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
          Padding(
            padding: const .only(left: 68),
            child: IntrinsicWidth(
              child: Container(
                height: 48,
                padding: .only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: .horizontal(right: .circular(6)),
                  color: Colors.bg1,
                ),
                child: Center(child: Text('Tambah Balok')),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: SvgPicture.asset(
              colorFilter: .mode(Colors.bg1, .srcIn),
              'assets/paths/VplBoth.svg',
            ),
          ),
        ],
      ),
    );
  }
}
