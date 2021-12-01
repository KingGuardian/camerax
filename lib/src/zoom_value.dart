class ZoomValue {
  final double minimum;
  final double maximum;
  final double value;

  const ZoomValue(this.minimum, this.maximum, this.value);

  ZoomValue copyWith({double? value}) {
    value ??= this.value;
    return ZoomValue(minimum, maximum, value);
  }
}
