import 'package:expense_bud/core/utils/date_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DateTime date;
  setUp(() {
    date = DateTime(2022, 2, 22);
  });

  test('it should format date according to pattern', () {
    final DateFormatter dateFormatter = DateFormatter("d MMM, yyyy");
    expect(dateFormatter.datetimeToString(date), "22 Feb, 2022");

    final DateFormatter defaultDateFormatter = DateFormatter.instance;
    expect(defaultDateFormatter.datetimeToString(date), "Tue, 22 Feb");
  });

  test('it should parse date string into key format', () {
    final DateFormatter dateFormatter = DateFormatter(kStorageDateFormat);
    final str = date.toIso8601String();
    expect(dateFormatter.stringToKey(str), "2022-02-22");
  });
}
