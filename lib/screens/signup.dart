import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project02_hackloop/utils/color.dart';
import 'package:project02_hackloop/widgets/reusable.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  File? _selectedImage;

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  Future<void> makeUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => () {});
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
              _selectedImage != null
                  ? ClipRRect(
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.fitWidth,
                        width: 150,
                        height: 150,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    )
                  : ClipRRect(
                      child: Image.asset(
                        "assets/images/user.jpg",
                        fit: BoxFit.fitWidth,
                        width: 150,
                        height: 150,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        return Colors.black.withOpacity(0.1);
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {
                    _pickImage();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.image,
                          size: 24,
                          color: Colors.white70,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Pick Photo",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.6),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
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

  Future _pickImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }
}
