import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateUtils {
  static DateUtils utils;

  DateUtils.createInstance();

  factory DateUtils() {
    if (utils == null) {
      utils = DateUtils.createInstance();
    }
    return utils;
  }

  Future<String> selectDate(BuildContext context, String date) async {
    final DateTime picked = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        initialDate: DateTime.now(),
        lastDate: DateTime(2021));
    if (picked != null) return formatDate(picked);

    return "";
  }

  Future<String> selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child,
        );
      },
    );
    if (picked != null) {
      return timeFormat(picked);
    }

    return "";
  }

  String timeFormat(TimeOfDay picked) {
    var hour = 00;
    var time = "PM";
    if (picked.hour >= 12) {
      time = "PM";
      if (picked.hour > 12) {
        hour = picked.hour - 12;
      } else if (picked.hour == 00) {
        hour = 12;
      } else {
        hour = picked.hour;
      }
    } else {
      time = "AM";
      if (picked.hour == 00) {
        hour = 12;
      } else {
        hour = picked.hour;
      }
    }
    var h, m;
    if (hour % 100 < 10) {
      h = "0" + hour.toString();
    } else {
      h = hour.toString();
    }

    int minute = picked.minute;
    if (minute % 100 < 10)
      m = "0" + minute.toString();
    else
      m = minute.toString();

    return h + ":" + m + " " + time;
  }

  String formatDate(DateTime selectedDate) =>
      new DateFormat("d MMM, y").format(selectedDate);
}
