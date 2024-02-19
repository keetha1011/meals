import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project02_hackloop/utils/color.dart';
import 'package:project02_hackloop/widgets/reusable.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  Future<void> makeUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print(getUsername());
      FirebaseAuth.instance.signOut();
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "meals.admn@gmail.com", password: "mealsappadmin");
      showDialog(
          context: context,
          builder: (context) => alertMe(
              context,
              "User Creation Success",
              [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Ok"))
              ],
              Text("User Created")));
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => alertMe(
              context,
              "User Creation Error",
              [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Ok"))
              ],
              Text("$e")));
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
              ),
            ),
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              SizedBox(
                height: 100,
              ),
              logoWidget("assets/logo/meals_large.png", 240, 160),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 25),
                child: Divider(
                  color: toColor("d4d4d4"),
                  thickness: 2,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                child: reusableTextField(
                    "Email", Icons.person_outline, false, _emailTextController),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                child: reusableTextField("Password", Icons.lock_outlined, true,
                    _passwordTextController),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: uiButton(context, "Sign Up", () {
                  makeUser(
                      _emailTextController.text, _passwordTextController.text);
                }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 25),
                child: Divider(
                  color: toColor("d4d4d4"),
                  thickness: 2,
                ),
              ),
            ]))));
  }
}
