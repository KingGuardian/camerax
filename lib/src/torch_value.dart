class TorchValue {
  final bool available;
  final bool state;

  const TorchValue(this.available, this.state);

  TorchValue copyWith({bool? state}) {
    state ??= this.state;
    return TorchValue(available, state);
  }
}
