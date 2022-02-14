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

  test('it should parse date string into [Day] key format', () {
    final DateFormatter dateFormatter = DateFormatter(kDay);
    final str = date.toIso8601String();
    expect(dateFormatter.stringToKey(str), "2022-02-22");
  });

  test('it should parse date string into [Month] key format', () {
    final DateFormatter dateFormatter = DateFormatter(kMonth);
    final str = date.toIso8601String();
    expect(dateFormatter.stringToKey(str), "2022-02");
  });

  group("getWeekOfMonth", () {
    test("it returns the week of the month of the given date", () {
      final fmt = DateFormatter.instance;
      final result1 = fmt.getWeekOfMonth(DateTime(2022, 2, 5));
      final result2 = fmt.getWeekOfMonth(DateTime(2022, 2, 10));
      final result3 = fmt.getWeekOfMonth(DateTime(2022, 2, 15));
      expect(result1, equals(1));
      expect(result2, equals(2));
      expect(result3, equals(3));
    });
    group("edge cases", () {
      test("when given day is the first of the month", () {
        final fmt = DateFormatter.instance;
        final result = fmt.getWeekOfMonth(DateTime(2022, 10, 1));
        expect(result, equals(1));
      });
      test("when given day is the last of the month #1", () {
        final fmt = DateFormatter.instance;
        final result = fmt.getWeekOfMonth(DateTime(2022, 9, 30));
        expect(result, equals(5));
      });
      test("when given day is the last of the month #2", () {
        final fmt = DateFormatter.instance;
        final result = fmt.getWeekOfMonth(DateTime(2022, 10, 31));
        expect(result, equals(6));
      });
    });
  });
}
