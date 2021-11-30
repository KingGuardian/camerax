class TorchValue {
  final bool available;
  final bool state;

  TorchValue._(this.available, this.state);

  TorchValue _copyWith({bool? state}) {
    state ??= this.state;
    return TorchValue._(available, state);
  }
}
