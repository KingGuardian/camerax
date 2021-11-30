class ZoomValue {
  double minimum;
  double maximum;
  double value;

  ZoomValue._(this.minimum, this.maximum, this.value);

  ZoomValue _copyWith({double? value}) {
    value ??= this.value;
    return ZoomValue._(minimum, maximum, value);
  }
}
