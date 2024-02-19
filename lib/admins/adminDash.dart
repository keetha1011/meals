import 'package:flutter/material.dart';
import 'package:project02_hackloop/utils/color.dart';
import 'package:project02_hackloop/utils/qr.dart';
import 'package:project02_hackloop/widgets/reusable.dart';

class adminDash extends StatefulWidget {
  const adminDash({super.key});

  @override
  State<adminDash> createState() => _adminDashState();
}

class _adminDashState extends State<adminDash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [toColor("BB1009"), toColor("610000")],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              SizedBox(height: 120),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: logoWidget("assets/logo/meals_large.png", 200, 100)),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 25),
                child: Divider(
                  color: toColor("d4d4d4"),
                  thickness: 2,
                ),
              ),
              QRScannerWidget(onScan: (String? code) {
                if (code != null) {
                  print('Scanned QR code: $code');
                }
              })
            ]))));
  }
}
