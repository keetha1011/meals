import 'package:flutter/material.dart';
import 'package:project02_hackloop/screens/home.dart';
import 'package:project02_hackloop/screens/navig.dart';
import 'package:project02_hackloop/utils/color.dart';
import 'package:project02_hackloop/widgets/reusable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  Future<void> addAuthentication() async {
    try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailTextController.text,
          password: _passwordTextController.text).then((value) => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => navigation()),
          ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'invalid-credential') {
        showDialog(context: context, builder: (context)=> alertMe(context, "Wrong Password", [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("Ok"))
        ], Text("Wrong Password, Try Again")));
      } else {
        print("Auth done!");
      }
    }
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
            padding: EdgeInsets.fromLTRB(
                20, 80, 20, 0),
            child: Column(children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(0,0,0,60),
                child:logoWidget("assets/logo/meals_large.png", 320, 240)
              ),
              reusableTextField("Enter UserName", Icons.person_outline, false,
                  _emailTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Password", Icons.lock_outline, true,
                  _passwordTextController),
              const SizedBox(height: 5),
              uiButton(context, "Login", addAuthentication),
              Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child:fadeMeIn(Text("M.E.A.L.S. (Meal Efficiency & Automated Logistics System)",
                style: TextStyle(color: toColor("d4d4d4"), fontSize: 12)),150)
              ),
            ]),
          ))),
    );
  }
}
