import 'package:flutter/material.dart';
import 'package:project02_hackloop/graph/barGraph.dart';
import 'package:project02_hackloop/main.dart';
import 'package:project02_hackloop/utils/color.dart';

class dash extends StatefulWidget {
  const dash({super.key});

  @override
  State<dash> createState() => _dashState();
}

class _dashState extends State<dash> {
  List<int> weekExp = [0, 0, 0, 0, 0, 0, 0];
  expData? myWeekExp;
  double fullMonth = 0;

  void initState() {
    super.initState();
    getDailyExp().then((data) {
      setState(() {
        myWeekExp = data;
        weekExp = [
          myWeekExp!.d0,
          myWeekExp!.d1,
          myWeekExp!.d2,
          myWeekExp!.d3,
          myWeekExp!.d4,
          myWeekExp!.d5,
          myWeekExp!.d6
        ];
        print(myWeekExp);
      });
    });
    super.initState();
    fullMonthExp().then((data) {
      setState(() {
        fullMonth = data;
      });
    });
  }

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
            )),
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 80, 10, 40),
                        child: Text(
                          "Expenditure Dashboard",
                          style: TextStyle(
                            color: toColor("d4d4d4"),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Divider(
                        color: toColor("d4d4d4"),
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: SizedBox(
                            height: 200,
                            child: MyBar(
                              thisWeek: weekExp,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                        child: Text(
                          "Daily Expenditure",
                          style: TextStyle(
                              color: toColor("d4d4d4"),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(
                        color: toColor("d4d4d4"),
                        thickness: 1,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            children: [
                              Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  color: toColor("d4d4d4"),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 30, 20, 30),
                                      child: Text(
                                        "Current Month: ₹${fullMonth}",
                                        style: TextStyle(
                                            color: toColor("666666"),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ])))));
  }
}
