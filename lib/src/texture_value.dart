class TextureValue {
  final int id;
  final int width;
  final int height;
  final int quarterTurns;

  const TextureValue(
    this.id,
    this.width,
    this.height,
    this.quarterTurns,
  );

  TextureValue copyWith({int? quarterTurns}) {
    quarterTurns ??= this.quarterTurns;
    return TextureValue(
      id,
      width,
      height,
      quarterTurns,
    );
  }
}
