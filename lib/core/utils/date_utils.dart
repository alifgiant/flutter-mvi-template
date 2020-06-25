import 'package:intl/intl.dart';

extension DateUtils on DateTime {
  // Monday, 23 Dec 2019
  String standardFormat() {
    return DateFormat('EEEE, dd MMM yyyy').format(this);
  }

  bool isBetween(DateTime before, DateTime after) {
    return this.isAfter(before) && this.isBefore(after);
  }
}
