import 'package:flutter_svg/flutter_svg.dart';
import 'package:ikarus/design.dart';

enum IkarusLogoType { wide, square }

class IkarusLogo extends StatelessWidget {
  final IkarusLogoType? type;
  final double? width;
  final double? height;
  final Color? color;

  const IkarusLogo({super.key, this.type, this.width, this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      width: width,
      height: height,
      colorFilter: .mode(color ?? Colors.fg0, .srcIn),
      switch (type) {
        .square => 'assets/images/IkarusSquareLogo.svg',
        _ => 'assets/images/IkarusLogo.svg',
      },
    );
  }
}
