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
  
  late MealData mealData;
  @override
  void initState() {
    super.initState();
    getMealData('wVjEr23OuiRIJMMTw1ZD').then((data) {
      setState(() {
        mealData = data;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    debugPrint(tomdate());
    return Scaffold(
      appBar: AppBar(title: const Icon(Icons.fastfood,size: 30,), iconTheme: const IconThemeData(color: Color.fromARGB(212, 255, 255, 255)),
      backgroundColor: toColor("BB1009"),foregroundColor: toColor("d4d4d4"),
      centerTitle: true,
      actions: <Widget>[
        IconButton(onPressed: (){
          Navigator.push(context,
                      MaterialPageRoute(builder: (context) => usercenter()));
        }, icon: const Icon(Icons.person))
      ],),
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
                  Padding(padding: EdgeInsets.fromLTRB(10, 80, 10, 00),child: logoWidget("assets/logo/meals.png",240,60)),
                  Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 80),child:Text("For "+tomdate(), style: TextStyle(color: toColor("d4d4d4"), fontSize: 18, fontWeight: FontWeight.bold))),
                  newcard(context, "Breakfast is ${mealData.breakfast}", (){}),
                  newcard(context, "Lunch is ${mealData.lunch}", (){}),
                  newcard(context, "Snacks is ${mealData.snacks}", (){}),
                  newcard(context, "Dinner is ${mealData.dinner}", (){}),
                ]
              ),
            )
        )
      ),
    );
  }
}
