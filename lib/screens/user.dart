import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project02_hackloop/screens/info.dart';
import 'package:project02_hackloop/screens/signin.dart';
import 'package:project02_hackloop/utils/color.dart';
import 'package:project02_hackloop/utils/time.dart';
import 'package:project02_hackloop/widgets/reusable.dart';

class usercenter extends StatefulWidget {
  const usercenter({Key? key}) : super(key: key);

  @override
  _usercenterState createState() => _usercenterState();
}

class _usercenterState extends State<usercenter> {
  @override
  Widget build(BuildContext context) {
    String username = getUsername();
    double len = MediaQuery.of(context).size.height-720;
    if(len <= 100){
      len = 100;
    }
    String qrdata = getUsername()+hournow().toString()+tomdate();
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
                  Padding(padding: EdgeInsets.fromLTRB(10, 50, 10, 0),child:DownloadAndDisplayImage()),
                  Padding(padding: EdgeInsets.fromLTRB(10, 30, 10, 0),child:fadeMeIn(Text("$username", style: TextStyle(color: toColor("d4d4d4"), fontSize: 30, fontWeight: FontWeight.bold)),0)),
                  Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 20),child:fadeMeIn(Text("(Contact admin for User Credentials)", style: TextStyle(color: toColor("d4d4d4"), fontSize: 18, fontWeight: FontWeight.bold)),50)),
                  fadeMeIn(
                    genQR(qrdata),100
                  ),
                  SizedBox(height: len),
                  fadeMeIn(uiButton(context, "Logout", () async{
                    await FirebaseAuth.instance.signOut().then((value) => Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                      (Route<dynamic> route) => false));
                  }),100),
                  Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child:fadeMeIn(TextButton(onPressed: (){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => infoscreen()),
                      );
                    },
                    child: Text("M.E.A.L.S.(Meal Efficiency & Automated Logistics System)",
                      style: TextStyle(color: toColor("d4d4d4"), fontSize: 12),textAlign: TextAlign.center,)),150)
                  ),
                ]
              ),
            )
        )
      ),
    );
  }
}

