import 'package:intl/intl.dart';

import 'package:expense_bud/core/utils/extensions.dart';

class Currency {
  final String name, symbol, locale;
  Currency({
    required this.name,
    required this.symbol,
    required this.locale,
  });
}

class MoneyFormatter {
  final NumberFormat _currencyFormatter;
  MoneyFormatter._(Currency currency)
      : _currencyFormatter = NumberFormat.currency(
          name: currency.name,
          symbol: currency.symbol,
          locale: currency.locale,
        );

  static MoneyFormatter instance = MoneyFormatter._(
    Currency(
      name: "",
      symbol: "",
      locale: "en_US",
    ),
  );

  factory MoneyFormatter({Currency? currency}) {
    if (currency == null) return instance;
    return MoneyFormatter._(currency);
  }

  String stringToMoney(String str) {
    final value = _currencyFormatter.format(str.toFloat());
    return value;
  }

  String get name => _currencyFormatter.currencyName ?? "";
}
