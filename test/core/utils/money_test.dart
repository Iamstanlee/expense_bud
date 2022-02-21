import 'package:expense_bud/core/utils/money.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('it should format input value into integral value', () {
    final money = Money();
    const double input1 = 1.24;
    const double input2 = 2345.67;
    expect(money.value(input1), equals(124));
    expect(money.value(input2), equals(234567));
  });

  test('it should format integral value into readable string', () {
    final money = Money();
    const input = 20025;
    expect(money.formatValue(input), equals("${money.code}200.25"));
  });
}
