import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project02_hackloop/admins/adminDash.dart';
import 'package:project02_hackloop/main.dart';
import 'package:project02_hackloop/screens/deleteUser.dart';
import 'package:project02_hackloop/screens/signin.dart';
import 'package:project02_hackloop/screens/signup.dart';
import 'package:project02_hackloop/utils/color.dart';
import 'package:project02_hackloop/widgets/reusable.dart';

class adminHome extends StatefulWidget {
  const adminHome({super.key});

  @override
  State<adminHome> createState() => _adminHomeState();
}

class _adminHomeState extends State<adminHome> {
  TextEditingController breakfastText = TextEditingController();
  TextEditingController lunchText = TextEditingController();
  TextEditingController snacksText = TextEditingController();
  TextEditingController dinnerText = TextEditingController();
  MealData? mealData;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getMealData('wVjEr23OuiRIJMMTw1ZD').then((data) {
      setState(() {
        mealData = data;
        print(data.breakfast);
      });
    });
  }

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
          child: Column(
            children: <Widget>[
              AppBar(
                centerTitle: true,
                backgroundColor: toColor("aa1009"),
                title: Text('Admin Home'),
                foregroundColor: toColor("e4e4d4"),
                actions: <Widget>[
                  PopupMenuButton<int>(
                    icon: Icon(Icons.settings),
                    itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text('Dashboard'),
                      ),
                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text('Logout'),
                      ),
                    ],
                    onSelected: (int value) async {
                      switch (value) {
                        case 0:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => adminDash()));
                          break;
                        case 1:
                          await FirebaseAuth.instance.signOut().then((value) =>
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignIn()),
                                  (Route<dynamic> route) => false));
                          break;
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 60),
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
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: inputCard("breakfast", () {
                    FirebaseFirestore.instance
                        .collection('mealsfortom')
                        .doc('wVjEr23OuiRIJMMTw1ZD')
                        .set({"breakfast": breakfastText.text},
                            SetOptions(merge: true));
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => adminHome()));
                    ;
                  }, breakfastText, "${mealData?.breakfast}")),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: inputCard("lunch", () {
                    FirebaseFirestore.instance
                        .collection('mealsfortom')
                        .doc('wVjEr23OuiRIJMMTw1ZD')
                        .set(
                            {"lunch": lunchText.text}, SetOptions(merge: true));
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => adminHome()));
                    ;
                  }, lunchText, "${mealData?.lunch}")),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: inputCard("snacks", () {
                    FirebaseFirestore.instance
                        .collection('mealsfortom')
                        .doc('wVjEr23OuiRIJMMTw1ZD')
                        .set({"snacks": snacksText.text},
                            SetOptions(merge: true));
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => adminHome()));
                    ;
                  }, snacksText, "${mealData?.snacks}")),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: inputCard("dinner", () {
                    FirebaseFirestore.instance
                        .collection('mealsfortom')
                        .doc('wVjEr23OuiRIJMMTw1ZD')
                        .set({"dinner": dinnerText.text},
                            SetOptions(merge: true));
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => adminHome()));
                    ;
                  }, dinnerText, "${mealData?.dinner}")),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                child: Divider(
                  color: toColor("d4d4d4"),
                  thickness: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                child: Text(
                  "User Settings",
                  style: TextStyle(
                      color: toColor("d4d4d4"),
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 80,
                      child: uiButton(context, "New User", () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => signup()));
                      }),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 80,
                      child: uiButton(context, "Delete User", () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => deleteUser()));
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
