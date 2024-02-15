import 'package:flutter/material.dart';
import 'package:project02_hackloop/utils/color.dart';

class dash extends StatefulWidget {
  const dash({super.key});

  @override
  State<dash> createState() => _dashState();
}

class _dashState extends State<dash> {
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
                    padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
                    child: Text("Dashboard", style: TextStyle(color: toColor("d4d4d4"), fontSize: 30, fontWeight: FontWeight.bold),),
                  ),
                ]
              )
            )
          )
      )
    );
  }
}