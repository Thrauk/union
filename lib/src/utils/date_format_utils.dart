// ignore_for_file: avoid_classes_with_only_static_members

import 'package:intl/intl.dart';

class DateFormatUtils {
  static String timestampToDate(int timestamp) {
    final DateFormat df = DateFormat.MMMMd('en_US').add_Hm();
    final DateTime date = DateTime.fromMicrosecondsSinceEpoch(timestamp);
    return df.format(date);
  }
}
