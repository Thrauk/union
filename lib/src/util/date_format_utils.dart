// ignore_for_file: avoid_classes_with_only_static_members

import 'package:intl/intl.dart';

class DateFormatUtils {
  static String timestampToDate(int timestamp) {
    // final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    // final String time = DateFormat.yMEd('en_us').format(date);
    // return time;

    final DateFormat df = DateFormat.MMMMd('en_US').add_Hm();
    final DateTime date = DateTime.fromMicrosecondsSinceEpoch(timestamp);
    return df.format(date);

  }
}
