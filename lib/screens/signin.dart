import 'package:flutter/material.dart';
import 'package:project02_hackloop/screens/home.dart';
import 'package:project02_hackloop/utils/color.dart';
import 'package:project02_hackloop/widgets/reusable.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
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
              padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height*0.1 , 20, 0),
              child: Column(
                children: <Widget>[
                  logoWidget("assets/logo/meals.png",320,240),
                  reusableTextField("Enter UserName", Icons.person_outline, false,_emailTextController),
                  const SizedBox(height: 20,),
                  reusableTextField("Enter Password", Icons.lock_outline, true,_passwordTextController),
                  const SizedBox(height: 5),
                  uiButton(context, "Login", () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                  }),
                  ImageWidget("assets/images/banner.png", 300, 240),
                ]
              ),
            )
        )
      ),
    );
  }
}
