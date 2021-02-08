import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateExtension on DateTime {

  String dateToString({@required String format}) {
    if (this == null) {
      return '';
    }
    return DateFormat(format).format(this);
  }

  int daysOfMonth() {
    DateTime beginningNextMonth = (this.month < 12)
        ? new DateTime(this.year, this.month + 1, 1)
        : new DateTime(this.year + 1, 1, 1);
    return beginningNextMonth.subtract(new Duration(days: 1)).day;
  }

  bool isToday() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateCheck = DateTime(this.year, this.month, this.day);
    return today == dateCheck;
  }


}
