// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:project02_hackloop/main.dart';
import 'package:project02_hackloop/screens/user.dart';
import 'package:project02_hackloop/utils/color.dart';
import 'package:project02_hackloop/utils/time.dart';
import 'package:project02_hackloop/widgets/reusable.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isThumbsUp0 = true;
  bool isThumbsUp1 = true;
  bool isThumbsUp2 = true;
  bool isThumbsUp3 = true;
  ChoiceData? choiceData;
  MealData? mealData;

  @override
  void initState() {
    super.initState();
    getMealData('wVjEr23OuiRIJMMTw1ZD').then((data) {
      setState(() {
        mealData = data;
      });
    });
    super.initState();
    getChoiceData(getUsername()).then((data) {
      setState(() {
        choiceData = data;
        isThumbsUp0 = choiceData!.breakfast;
        isThumbsUp1 = choiceData!.lunch;
        isThumbsUp2 = choiceData!.snacks;
        isThumbsUp3 = choiceData!.dinner;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    int hourNow = hournow();
    int breTime = 6, lunTime = 10, sncTime = 16, dinTime = 18;

    void toggleThumbsUp0() {
      if (hourNow<breTime){
      setState(() {
        isThumbsUp0 = !isThumbsUp0;
        updateDataInFirestore('choice', getUsername(), "breakfast", isThumbsUp0);
      });
      }else{
        showDialog(context: context, builder: (context)=> alertMe(context, "Too Late!", [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("Ok"))
        ], Text("You Should Update this before 6AM")));
      }
    }
    void toggleThumbsUp1() {
      if (hourNow<breTime){
      setState(() {
        isThumbsUp1 = !isThumbsUp1;
        updateDataInFirestore('choice', getUsername(), "lunch", isThumbsUp1);
      });
      }else{
        showDialog(context: context, builder: (context)=> alertMe(context, "Too Late!", [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("Ok"))
        ], Text("You Should Update this before 10AM")));
      }
    }
    void toggleThumbsUp2() {
      if (hourNow<breTime){
      setState(() {
        isThumbsUp2 = !isThumbsUp2;
        updateDataInFirestore('choice', getUsername(), "snacks", isThumbsUp2);
      });
      }else{
        showDialog(context: context, builder: (context)=> alertMe(context, "Too Late!", [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("Ok"))
        ], Text("You Should Update this before 4PM")));
      }
    }
    void toggleThumbsUp3() {
      if (hourNow<breTime){
      setState(() {
        isThumbsUp3 = !isThumbsUp3;
        updateDataInFirestore('choice', getUsername(), "dinner", isThumbsUp3);
      });
      }else{
        showDialog(context: context, builder: (context)=> alertMe(context, "Too Late!", [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("Ok"))
        ], Text("You Should Update this before 6PM")));
      }
    }

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
                  Padding(padding: EdgeInsets.fromLTRB(10, 150, 10, 00),child: fadeMeIn(logoWidget("assets/logo/meals.png",140,60),0)),
                  Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 40),child:fadeMeIn(Text("For "+tomdate(), style: TextStyle(color: toColor("d4d4d4"), fontSize: 18, fontWeight: FontWeight.bold)),0)),
                  fadeMeIn(newcard(context, "Breakfast is ${mealData?.breakfast}", toggleThumbsUp0, isThumbsUp: isThumbsUp0),50),
                  fadeMeIn(newcard(context, "Lunch is ${mealData?.lunch}", toggleThumbsUp1, isThumbsUp: isThumbsUp1),100),
                  fadeMeIn(newcard(context, "Snacks is ${mealData?.snacks}", toggleThumbsUp2, isThumbsUp: isThumbsUp2),150),
                  fadeMeIn(newcard(context, "Dinner is ${mealData?.dinner}", toggleThumbsUp3, isThumbsUp: isThumbsUp3),200),
                ]
              ),
            )
        )
      ),
    );
  }
}
