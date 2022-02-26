class Pair<L, R> {
  final L left;
  final R right;
  const Pair(this.left, this.right);

  Pair<L, R> copyWith({
    L? left,
    R? right,
  }) {
    return Pair<L, R>(
      left ?? this.left,
      right ?? this.right,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Pair<L, R> && other.left == left && other.right == right;
  }

  @override
  int get hashCode => left.hashCode ^ right.hashCode;
}
