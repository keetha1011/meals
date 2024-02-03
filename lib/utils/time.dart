import 'package:ntp/ntp.dart';

String tomdate() {
  DateTime internetTime = DateTime.now();

  NTP.getNtpOffset(
    localTime: DateTime.now(), lookUpAddress: "time.google.com").then((offset) {
    internetTime = DateTime.now().add(Duration(milliseconds: offset));
  });

  DateTime tomorrow = internetTime.add(Duration(days: 1));

  String date = tomorrow.day.toString().padLeft(2, '0') + "/" +
      tomorrow.month.toString().padLeft(2, '0');

  return date;
}