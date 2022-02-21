import 'package:expense_bud/core/utils/currencies.dart';
import 'package:expense_bud/features/settings/domain/entities/currency.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class Money {
  final NumberFormat _formatter;
  final CurrencyEntity _currency;

  Money._(CurrencyEntity currency)
      : _currency = currency,
        _formatter = NumberFormat.currency(
          name: currency.name,
          symbol: currency.symbol,
          locale: currency.locale,
          decimalDigits: currency.minorUnits,
        );

  factory Money([CurrencyEntity? currency]) {
    return Money._(currency ?? usd);
  }
  Money formatWithEmptyString() => Money(_currency.copyWith(symbol: ""));

  String get code => _currency.name;
  int get scaleFactor => math.pow(10, _currency.minorUnits).round();

  /// use this to to get the integral value of a monetary input
  /// Eg for usd $1.24 becomes 124 cents
  int value(num input) => (input * scaleFactor).round();
  String formatValue(num input) => _formatter.format(input / scaleFactor);
}
