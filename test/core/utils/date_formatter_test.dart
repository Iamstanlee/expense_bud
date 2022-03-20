import 'package:expense_bud/core/utils/date_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DateTime date;
  setUp(() {
    date = DateTime(2022, 2, 22);
  });

  test('Dovrebbe formattare la data in base allo schema', () {
    final DateFormatter dateFormatter = DateFormatter("d MMM, yyyy");
    expect(dateFormatter.datetimeToString(date), "22 Feb, 2022");

    final DateFormatter defaultDateFormatter = DateFormatter.instance;
    expect(defaultDateFormatter.datetimeToString(date), "Tue, 22 Feb");
  });

  test('Dovrebbe analizzare la stringa data in formato chiave [giorno]', () {
    final DateFormatter dateFormatter = DateFormatter(kDay);
    final str = date.toIso8601String();
    expect(dateFormatter.stringToKey(str), "2022-02-22");
  });

  test('Dovrebbe analizzare la stringa della data nel formato chiave [mese]', () {
    final DateFormatter dateFormatter = DateFormatter(kMonth);
    final str = date.toIso8601String();
    expect(dateFormatter.stringToKey(str), "2022-02");
  });

  group("getWeekOfMonth", () {
    test("Restituisce la settimana del mese della data data", () {
      final fmt = DateFormatter.instance;
      final result1 = fmt.getWeekOfMonth(DateTime(2022, 2, 5));
      final result2 = fmt.getWeekOfMonth(DateTime(2022, 2, 10));
      final result3 = fmt.getWeekOfMonth(DateTime(2022, 2, 15));
      expect(result1, equals(1));
      expect(result2, equals(2));
      expect(result3, equals(3));
    });
    group("edge cases", () {
      test("Quando viene dato il giorno è il primo del mese", () {
        final fmt = DateFormatter.instance;
        final result = fmt.getWeekOfMonth(DateTime(2022, 10, 1));
        expect(result, equals(1));
      });
      test("Quando viene dato il giorno è l'ultimo del mese #1", () {
        final fmt = DateFormatter.instance;
        final result = fmt.getWeekOfMonth(DateTime(2022, 9, 30));
        expect(result, equals(5));
      });
      test("Quando viene dato il giorno è l'ultimo del mese #2", () {
        final fmt = DateFormatter.instance;
        final result = fmt.getWeekOfMonth(DateTime(2022, 10, 31));
        expect(result, equals(6));
      });
    });
  });
}
