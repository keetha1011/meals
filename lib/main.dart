import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project02_hackloop/Screens/signin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project02_hackloop/utils/time.dart';
import 'package:project02_hackloop/widgets/reusable.dart';
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
        MaterialPageRoute(builder: (context) => isAdmin(getUsername())),
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
  MealData(
      {required this.breakfast,
      required this.lunch,
      required this.snacks,
      required this.dinner});
}

Future<MealData> getMealData(String documentId) async {
  final db = FirebaseFirestore.instance;
  final collection = db.collection('mealsfortom');
  final document = collection.doc('wVjEr23OuiRIJMMTw1ZD');
  final data = await document.get();
  final mealData = data.data();

  String breakfast = 'default',
      lunch = 'default',
      snacks = 'default',
      dinner = 'default';
  if (mealData == null) {
    print("null data");
  } else {
    breakfast = await (mealData['breakfast'] as FutureOr<String>?) ?? 'default';
    lunch = await (mealData['lunch'] as FutureOr<String>?) ?? 'default';
    snacks = await (mealData['snacks'] as FutureOr<String>?) ?? 'default';
    dinner = await (mealData['dinner'] as FutureOr<String>?) ?? 'default';
  }
  return MealData(
      breakfast: breakfast, lunch: lunch, snacks: snacks, dinner: dinner);
}

class ChoiceData {
  bool breakfast, lunch, snacks, dinner;
  ChoiceData(
      {required this.breakfast,
      required this.lunch,
      required this.snacks,
      required this.dinner});
}

Future<ChoiceData> getChoiceData(String documentId) async {
  final db = FirebaseFirestore.instance;
  final collection = db.collection('choice');
  final document = collection.doc(documentId);
  final data = await document.get();
  final choiceData = data.data();

  bool breakfast = true, lunch = true, snacks = true, dinner = true;
  if (choiceData == null) {
    print("null data");
  } else {
    breakfast = await (choiceData['breakfast'] as FutureOr<bool>?) ?? true;
    lunch = await (choiceData['lunch'] as FutureOr<bool>?) ?? true;
    snacks = await (choiceData['snacks'] as FutureOr<bool>?) ?? true;
    dinner = await (choiceData['dinner'] as FutureOr<bool>?) ?? true;
  }
  return ChoiceData(
      breakfast: breakfast, lunch: lunch, snacks: snacks, dinner: dinner);
}

Future<void> createDocumentWithId(String collectionName, String documentId,
    Map<String, dynamic> documentData) async {
  FirebaseFirestore.instance
      .collection(collectionName)
      .doc(documentId)
      .set(documentData)
      .then((value) => print("Document added"))
      .catchError((error) => print("Failed to add document: $error"));
}

Future<void> updateDataInFirestore(String collectionName, String documentId,
    String fieldName, var newValue) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    await _firestore.collection(collectionName).doc(documentId).update({
      fieldName: newValue,
    });
    print('Data updated successfully!');
  } catch (e) {
    print('Error updating data: $e');
  }
}

class expData {
  int d0 = 0, d1 = 0, d2 = 0, d3 = 0, d4 = 0, d5 = 0, d6 = 0;
  expData({
    required this.d0,
    required this.d1,
    required this.d2,
    required this.d3,
    required this.d4,
    required this.d5,
    required this.d6,
  });
}

Future<expData> getDailyExp() async {
  final db = FirebaseFirestore.instance;
  final collection = db.collection('fees');
  final document = collection.doc('daily');
  final data = await document.get();
  final exp = data.data();
  String d;
  int d0 = 0, d1 = 0, d2 = 0, d3 = 0, d4 = 0, d5 = 0, d6 = 0;
  if (exp == null) {
    print("null data");
  } else {
    d = await (exp[getUsername()] as FutureOr<String>?) ??
        '0000000000000000000000000000000';
    d0 = convToExpence(d[pastDate(7) - 1]);
    d1 = convToExpence(d[pastDate(6) - 1]);
    d2 = convToExpence(d[pastDate(5) - 1]);
    d3 = convToExpence(d[pastDate(4) - 1]);
    d4 = convToExpence(d[pastDate(3) - 1]);
    d5 = convToExpence(d[pastDate(2) - 1]);
    d6 = convToExpence(d[pastDate(1) - 1]);
  }
  return expData(d0: d0, d1: d1, d2: d2, d3: d3, d4: d4, d5: d5, d6: d6);
}

Future<double> fullMonthExp() async {
  final db = FirebaseFirestore.instance;
  final collection = db.collection('fees');
  final document = collection.doc('daily');
  final data = await document.get();
  final exp = data.data();
  double Sum = 0;
  String d;
  if (exp == null) {
    print("null data");
  } else {
    d = await (exp[getUsername()] as FutureOr<String>?) ??
        '0000000000000000000000000000000';
    for (var i = 0; i < 31; i++) {
      Sum += convToExpence(d[i]);
    }
  }
  return Sum;
}
