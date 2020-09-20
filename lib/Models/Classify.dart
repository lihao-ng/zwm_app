class Classify {
  final int index;
  final double confidence;
  final String label;

  Classify({
    this.index,
    this.label,
    this.confidence,
  });

  getPercentage() {
    return this.confidence * 100;
  }
}
