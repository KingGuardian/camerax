class TextureValue {
  final int id;
  final int width;
  final int height;
  final int quarterTurns;

  TextureValue._(
    this.id,
    this.width,
    this.height,
    this.quarterTurns,
  );

  TextureValue _copyWith({int? quarterTurns}) {
    quarterTurns ??= this.quarterTurns;
    return TextureValue._(
      id,
      width,
      height,
      quarterTurns,
    );
  }
}
