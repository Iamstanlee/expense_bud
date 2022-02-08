import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:intl/intl.dart';
// import 'dart:math' as math;

const kStorageDateFormat = "yyyy-MM-dd";

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

  String relativeToNow(String date) {
    final thisInstant = DateTime.now();
    final diff = thisInstant.difference(date.toDateTime());

    if ((diff.inDays / 365).floor() >= 2) {
      return '${(diff.inDays / 365).floor()} years ago';
    } else if ((diff.inDays / 365).floor() >= 1) {
      return 'Last year';
    } else if ((diff.inDays / 30).floor() >= 2) {
      return '${(diff.inDays / 30).floor()} months ago';
    } else if ((diff.inDays / 30).floor() >= 1) {
      return 'Last month';
    } else if ((diff.inDays / 7).floor() >= 2) {
      return '${(diff.inDays / 7).floor()} weeks ago';
    } else if ((diff.inDays / 7).floor() >= 1) {
      return 'Last week';
    } else if (diff.inDays >= 2) {
      return '${diff.inDays} days ago';
    } else if (diff.inDays >= 1) {
      return 'Yesterday';
    } else if (diff.inHours >= 2) {
      return '${diff.inHours} hours ago';
    } else if (diff.inHours >= 1) {
      return '1 hour ago';
    } else if (diff.inMinutes >= 2) {
      return '${diff.inMinutes} minutes ago';
    } else if (diff.inMinutes >= 1) {
      return '1 minute ago';
    } else if (diff.inSeconds >= 3) {
      return '${diff.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}
