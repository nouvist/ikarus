import 'package:flutter_svg/flutter_svg.dart';
import 'package:ikarus/design.dart';

class NouvistLogo extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;

  const NouvistLogo({super.key, this.width, this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      width: width,
      height: height,
      colorFilter: .mode(color ?? const .new(0xffffffff), .srcIn),
      'assets/images/NouvistLogo.svg',
    );
  }
}
