import 'package:intl/intl.dart';

import 'package:expense_tracker/core/utils/extensions.dart';

// allow user to change currency???
class Currency {
  final String name, symbol, locale;
  Currency({
    required this.name,
    required this.symbol,
    required this.locale,
  });
}

class MoneyFormatter {
  MoneyFormatter._(Currency currency)
      : _currencyFormatter = NumberFormat.currency(
          name: currency.name,
          symbol: currency.symbol,
          locale: currency.locale,
        );

  final NumberFormat _currencyFormatter;
  static MoneyFormatter instance = MoneyFormatter._(
    Currency(
      name: "",
      symbol: "",
      locale: "en_NG",
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
}
