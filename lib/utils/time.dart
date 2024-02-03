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