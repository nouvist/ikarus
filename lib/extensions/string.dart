extension StringExtension on String {
  @pragma('vm:prefer-inline')
  String? get orNull {
    return switch (isEmpty) {
      true => null,
      false => this,
    };
  }
}
