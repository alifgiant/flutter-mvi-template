import 'package:intl/intl.dart';

extension DateUtils on DateTime {
  // Monday, 23 Dec 2019
  String standardFormat({bool withHour = false}) {
    final format = withHour ? 'EEEE, dd MMM yyyy, HH:mm' : 'EEEE, dd MMM yyyy';
    return DateFormat(format).format(this);
  }

  // Monday, 23 Dec 2019
  String formatNoDay({bool withHour = false}) {
    final format = withHour ? 'dd MMM yyyy, HH:mm' : 'dd MMM yyyy';
    return DateFormat(format).format(this);
  }

  bool isBetween(DateTime before, DateTime after) {
    return this.isAfter(before) && this.isBefore(after);
  }
}
