import 'package:expense_bud/core/utils/date_formatter.dart';
import 'package:hive/hive.dart';

abstract class LocalDataSource {
  final Box _box;
  LocalDataSource(this._box);
  final _dayFormatter = DateFormatter(kDay);
  final _monthFormatter = DateFormatter(kMonth);

  String getDayKey(String date) {
    return _dayFormatter.stringToKey(date);
  }

  String getMonthKey(String date) {
    return _monthFormatter.stringToKey(date);
  }

  bool has(String key) {
    return _box.containsKey(key);
  }
}
