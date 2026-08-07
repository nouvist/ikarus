import 'dart:math';

extension IntExtension on int {
  @pragma('vm:prefer-inline')
  int clampi([int lowerBound = 0, int upperBound = 1]) =>
      clamp(lowerBound, upperBound) as int;

  @pragma('vm:prefer-inline')
  int clampLower(int value) => max(this, value);

  @pragma('vm:prefer-inline')
  int clampUpper(int value) => min(this, value);
}
