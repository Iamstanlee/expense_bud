import 'package:expense_tracker/core/utils/money_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('it should format string into money value with no locale and symbol',
      () {
    final MoneyFormatter defaultMoneyFormatter = MoneyFormatter.instance;
    const str = "2000000";
    const result = "2,000,000.00";
    expect(defaultMoneyFormatter.stringToMoney(str), equals(result));
  });

  test('it should format string into money value with provided currency', () {
    final currency = Currency(name: "USD", symbol: "\$", locale: "en_US");
    final MoneyFormatter defaultMoneyFormatter =
        MoneyFormatter(currency: currency);
    const str = "2000";
    const result = "\$2,000.00";
    expect(defaultMoneyFormatter.stringToMoney(str), equals(result));
  });
}
