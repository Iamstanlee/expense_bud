class CurrencyEntity {
  final String name;
  final String symbol;
  final int minorUnits;
  final String? locale;
  const CurrencyEntity({
    required this.name,
    required this.locale,
    this.minorUnits = 2,
    this.symbol = "",
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrencyEntity &&
        other.name == name &&
        other.locale == locale &&
        other.minorUnits == minorUnits;
  }

  @override
  int get hashCode {
    return name.hashCode ^ locale.hashCode ^ minorUnits.hashCode;
  }

  CurrencyEntity copyWith({
    String? name,
    String? symbol,
    int? minorUnits,
    String? locale,
  }) {
    return CurrencyEntity(
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      minorUnits: minorUnits ?? this.minorUnits,
      locale: locale ?? this.locale,
    );
  }
}
