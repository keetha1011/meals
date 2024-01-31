import 'package:flutter/material.dart';
import 'package:project02_hackloop/screens/signin.dart';
import 'package:project02_hackloop/utils/color.dart';
import 'package:project02_hackloop/widgets/reusable.dart';

class usercenter extends StatefulWidget {
  const usercenter({Key? key}) : super(key: key);

  @override
  _usercenterState createState() => _usercenterState();
}

class _usercenterState extends State<usercenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Icon(Icons.person,size: 30,), iconTheme: const IconThemeData(color: Color.fromARGB(212, 255, 255, 255)),
      backgroundColor: toColor("BB1009"),foregroundColor: toColor("d4d4d4"),
      centerTitle: true,
      ),
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
                  uiButton(context, "Logout", (){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                  })
                ]
              ),
            )
        )
      ),
    );
  }
}
