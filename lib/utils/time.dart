import 'package:ntp/ntp.dart';

String tomdate() {
  DateTime internetTime = DateTime.now();

  NTP.getNtpOffset(
    localTime: DateTime.now(), lookUpAddress: "time.google.com").then((offset) {
    internetTime = DateTime.now().add(Duration(milliseconds: offset));
  });

  DateTime today = internetTime;

  String date = today.day.toString().padLeft(2, '0') + "/" +
      today.month.toString().padLeft(2, '0');

  return date;
}

int hournow() {
  DateTime internetTime = DateTime.now();

  NTP.getNtpOffset(
    localTime: DateTime.now(), lookUpAddress: "time.google.com").then((offset) {
    internetTime = DateTime.now().add(Duration(milliseconds: offset));
  });

  DateTime today = internetTime;

  int hour = today.hour;

  return hour;
}

int pastDate(int past) {
  DateTime internetTime = DateTime.now();

  NTP.getNtpOffset(
    localTime: DateTime.now(), lookUpAddress: "time.google.com").then((offset) {
    internetTime = DateTime.now().add(Duration(milliseconds: offset));
  });

  internetTime = internetTime.subtract(Duration(days: past));
  int date = internetTime.day;
  return date;
}

int thisMonth() {
  DateTime internetTime = DateTime.now();

  NTP.getNtpOffset(
    localTime: DateTime.now(), lookUpAddress: "time.google.com").then((offset) {
    internetTime = DateTime.now().add(Duration(milliseconds: offset));
  });
  int mon = internetTime.month;
  return mon;
}