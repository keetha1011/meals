import 'package:flutter/material.dart';
import 'package:project02_hackloop/admins/adminHome.dart';
import 'package:project02_hackloop/main.dart';
import 'package:project02_hackloop/utils/color.dart';
import 'package:project02_hackloop/widgets/reusable.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

class adminDash extends StatefulWidget {
  const adminDash({super.key});

  @override
  State<adminDash> createState() => _adminDashState();
}

class _adminDashState extends State<adminDash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: toColor("bb1009"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: QRCodeDartScanView(
              scanInvertedQRCode:
                  true, // enable scan invert qr code ( default = false)
              typeScan: TypeScan.live,
              onCapture: (Result result) {
                updateDataInFirestore(
                    "attendance",
                    result.toString().substring(0, 10),
                    convHrToMeal(
                        int.parse(result.toString().substring(10, 11))),
                    true);
                showDialog(
                    context: context,
                    builder: (context) => alertMe(
                        context,
                        "Updated",
                        [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => adminHome()));
                              },
                              child: Text("Ok"))
                        ],
                        Text(
                            "attendece/${result.toString().substring(0, 10)}/${convHrToMeal(int.parse(result.toString().substring(10, 11)))}")));
              }),
        ));
  }
}
