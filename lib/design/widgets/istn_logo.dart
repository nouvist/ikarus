import 'package:flutter_svg/flutter_svg.dart';
import 'package:ikarus/design.dart';

class IstnLogo extends StatelessWidget {
  final double? radius;
  final Color? color;

  const IstnLogo({super.key, this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      width: radius,
      height: radius,
      colorFilter: .mode(color ?? .new(0xffffffff), .srcIn),
      'assets/images/IstnLogo.svg',
    );
  }
}
