class ExchangeRateEntity {
  final String base;
  final Map<String, double> rates;
  ExchangeRateEntity({
    required this.base,
    required this.rates,
  });
}
