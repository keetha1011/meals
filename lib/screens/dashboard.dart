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
  List<int> weekExp = [0,0,0,0,0,0,0];
  expData? myWeekExp;

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
              padding: const EdgeInsets.fromLTRB(20,0,20,20),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 100, 10, 30),
                    child: Text("Expenditure Dashboard", style: TextStyle(color: toColor("d4d4d4"), fontSize: 36, fontWeight: FontWeight.bold, ),textAlign: TextAlign.center,),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                    child: SizedBox(
                      height: 300,
                      child: MyBar(thisWeek: weekExp,)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text("Daily Expenditure", style: TextStyle(color: toColor("d4d4d4"), fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                ]
              )
            )
          )
      )
    );
  }
}