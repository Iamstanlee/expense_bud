import 'package:expense_bud/core/utils/extensions.dart';
import 'package:intl/intl.dart';

const kDay = "yyyy-MM-dd";
const kMonth = "yyyy-MM";

class DateFormatter {
  DateFormatter._(String pattern) : _dateFormatter = DateFormat(pattern);

  final DateFormat _dateFormatter;
  static DateFormatter instance = DateFormatter._("EEE, d MMM");

  factory DateFormatter([String? pattern]) {
    if (pattern == null) return instance;
    return DateFormatter._(pattern);
  }

  String datetimeToString(DateTime date) {
    final value = _dateFormatter.format(date);
    return value;
  }

  /// map date string to storage key
  String stringToKey(String str) {
    return datetimeToString(str.toDateTime());
  }

  int getWeekOfMonth(DateTime date) {
    int firstDayOfMonth = DateTime(date.year, date.month).weekday;
    int lastDayOfFirstWeek = 1 - firstDayOfMonth;
    if (lastDayOfFirstWeek <= 0) lastDayOfFirstWeek += 7;
    final remainingDaysAfterFirstWeek = date.day - lastDayOfFirstWeek;
    return (remainingDaysAfterFirstWeek / 7).ceil() + 1;
  }

  String relativeToNow(String date) {
    final thisInstant = DateTime.now();
    final diff = thisInstant.difference(date.toDateTime());

    if ((diff.inDays / 365).floor() >= 2) {
      return '${(diff.inDays / 365).floor()} anni fa';
    } else if ((diff.inDays / 365).floor() >= 1) {
      return 'Anno scorso';
    } else if ((diff.inDays / 30).floor() >= 2) {
      return '${(diff.inDays / 30).floor()} mesi fa';
    } else if ((diff.inDays / 30).floor() >= 1) {
      return 'Lo scorso mese';
    } else if ((diff.inDays / 7).floor() >= 2) {
      return '${(diff.inDays / 7).floor()} settimane fa';
    } else if ((diff.inDays / 7).floor() >= 1) {
      return 'La settimana scorsa';
    } else if (diff.inDays >= 2) {
      return '${diff.inDays} giorni fa';
    } else if (diff.inDays >= 1) {
      return 'Ieri';
    } else if (diff.inHours >= 2) {
      return '${diff.inHours} ore fa';
    } else if (diff.inHours >= 1) {
      return '1 ora fa';
    } else if (diff.inMinutes >= 2) {
      return '${diff.inMinutes} minuti fa';
    } else if (diff.inMinutes >= 1) {
      return '1 minuto fa';
    } else if (diff.inSeconds >= 3) {
      return '${diff.inSeconds} secondi fa';
    } else {
      return 'Proprio adesso';
    }
  }
}
