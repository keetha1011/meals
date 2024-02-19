import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project02_hackloop/utils/color.dart';
import 'package:project02_hackloop/widgets/reusable.dart';

class deleteUser extends StatefulWidget {
  const deleteUser({super.key});

  @override
  State<deleteUser> createState() => _deleteUserState();
}

class _deleteUserState extends State<deleteUser> {
  Future<void> unmakeUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      FirebaseAuth.instance.currentUser!.delete();
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "meals.admn@gmail.com", password: "mealsappadmin");
    } catch (e) {
      print(e);
    }
  }

  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
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
                  child: uiButton(context, "Delete User", () {
                    unmakeUser(_emailTextController.text,
                        _passwordTextController.text);
                  })),
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
