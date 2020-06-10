import 'package:intl/intl.dart';

class SharedFunctions{

  formatDateTime(DateTime dateTime) {
    String date = DateFormat.yMd().format(dateTime);
    String time = DateFormat.jm().format(dateTime);
    return ('$date at $time');
  }

  getDateTime(Map<String, dynamic> dateTime){
    int inSeconds = dateTime['_seconds'];
    var date = new DateTime.fromMillisecondsSinceEpoch(inSeconds * 1000);
    return date;
  }

  getTimeDifference(DateTime dateTime) {
    DateTime now = new DateTime.now();
    int difference = dateTime.difference(now).inMinutes;
    return (difference);
  }

}