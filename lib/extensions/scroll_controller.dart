import 'package:flutter/widgets.dart';

extension ScrollControllerExtension on ScrollController {
  @pragma('vm:prefer-inline')
  double? get offsetOrNull => positions.firstOrNull?.pixels;

  @pragma('vm:prefer-inline')
  double get offsetOrZero => offsetOrNull ?? 0;
}
