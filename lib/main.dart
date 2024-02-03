import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project02_hackloop/Screens/signin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project02_hackloop/screens/home.dart';
import 'firebase_options.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    debugPrint("Connection Error");
    SnackBar(
      content: Text("Connection Error, Try Again"),
    );
    return;
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());

}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'M.E.A.L.S.',
        theme: ThemeData(
          useMaterial3: false,
          fontFamily: GoogleFonts.dmSans().fontFamily,
          primarySwatch: Colors.red,
        ),
        home: AuthenticationWrapper());
  }
}

class AuthenticationWrapper extends StatefulWidget {
  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUserAuthentication();
      });
  }
  void checkUserAuthentication() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
}


class MealData {
  String breakfast, lunch, snacks, dinner;
  MealData({required this.breakfast, required this.lunch, required this.snacks, required this.dinner});
}

Future<MealData> getMealData(String documentId) async {
  final db = FirebaseFirestore.instance;
  final collection = db.collection('mealsfortom');
  final document = collection.doc('wVjEr23OuiRIJMMTw1ZD');
  final data = await document.get();
  final mealData = data.data();
  
  String breakfast = 'default', lunch = 'default', snacks = 'default', dinner = 'default';
  if (mealData == null){
    print("null data");
  }
  else{
    breakfast = await (mealData['breakfast'] as FutureOr<String>?) ?? 'default';
    lunch = await (mealData['lunch'] as FutureOr<String>?) ?? 'default';
    snacks = await (mealData['snacks'] as FutureOr<String>?) ?? 'default';
    dinner = await (mealData['dinner'] as FutureOr<String>?) ?? 'default';
  }
  return MealData(breakfast: breakfast, lunch: lunch, snacks: snacks, dinner: dinner);
}