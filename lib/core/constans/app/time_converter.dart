class TimeConverter {
  static String getOnlyDate(DateTime time) {
    return '${time.day}/${time.month}/${time.year}';
  }

  String getOnlyClock(DateTime time) {
    var hour = time.hour.toString();
    var minute = time.minute.toString();

    if (time.minute < 10) minute = '0' + minute;
    if (time.hour < 10) hour = '0' + hour;

    return '$hour:$minute';
  }

  String getDateAndTime(DateTime time) {
    return '${time.hour}:${time.minute} - ${time.day}/${time.month}/${time.year}';
  }
}
