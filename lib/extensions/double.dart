import 'dart:math' as m;

extension DoubleExtension on double {
  @pragma('vm:prefer-inline')
  double clampd([double lowerBound = 0, double upperBound = 1]) =>
      clamp(lowerBound, upperBound) as double;

  @pragma('vm:prefer-inline')
  double clampLower(double value) => m.max(this, value);

  @pragma('vm:prefer-inline')
  double clampUpper(double value) => m.min(this, value);

  @pragma('vm:prefer-inline')
  double invlerp(double lowerBound, double upperBound) =>
      (this - lowerBound) / (upperBound - lowerBound);

  @pragma('vm:prefer-inline')
  double lerp(double lowerBound, double upperBound) =>
      this * (upperBound - lowerBound) + lowerBound;

  @pragma('vm:prefer-inline')
  double complementary() => 1 - this;

  @pragma('vm:prefer-inline')
  double pow(double exponent) => m.pow(this, exponent) as double;
}
