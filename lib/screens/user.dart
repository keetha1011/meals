import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project02_hackloop/screens/signin.dart';
import 'package:project02_hackloop/utils/color.dart';
import 'package:project02_hackloop/widgets/reusable.dart';
import 'package:firebase_storage/firebase_storage.dart';

class usercenter extends StatefulWidget {
  const usercenter({Key? key}) : super(key: key);

  @override
  _usercenterState createState() => _usercenterState();
}

class _usercenterState extends State<usercenter> {
  @override
  Widget build(BuildContext context) {
    String username = getUsername();

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
                  Padding(padding: EdgeInsets.fromLTRB(10, 50, 10, 0),child:DownloadAndDisplayImage()),
                  Padding(padding: EdgeInsets.fromLTRB(10, 30, 10, 0),child:fadeMeIn(Text("$username", style: TextStyle(color: toColor("d4d4d4"), fontSize: 30, fontWeight: FontWeight.bold)),0)),
                  Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 0),child:fadeMeIn(Text("(Contact admin for User Credentials)", style: TextStyle(color: toColor("d4d4d4"), fontSize: 18, fontWeight: FontWeight.bold)),50)),
                  SizedBox(height: 240,),
                  fadeMeIn(uiButton(context, "Logout", () async{
                    await FirebaseAuth.instance.signOut().then((value) => Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                      (Route<dynamic> route) => false));
                  }),100),
                  Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child:fadeMeIn(Text("M.E.A.L.S. (Meal Efficiency & Automated Logistics System)",
                    style: TextStyle(color: toColor("d4d4d4"), fontSize: 12)),150)
                  ),
                ]
              ),
            )
        )
      ),
    );
  }
}

class DownloadAndDisplayImage extends StatefulWidget {
  @override
  _DownloadAndDisplayImageState createState() => _DownloadAndDisplayImageState();
}

class _DownloadAndDisplayImageState extends State<DownloadAndDisplayImage> {
  String username = getUsername();
  final FirebaseStorage storage = FirebaseStorage.instance;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    downloadImage();
  }
  Future<void> downloadImage() async {
    try{
    final Reference imageRef = await storage.ref().child('userprof/$username.jpg');
    final String url = await imageRef.getDownloadURL();
    setState(() {
      imageUrl = url;
    });} on FirebaseException catch (e) {
      print("exception $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return ClipRRect(child: Image.network(imageUrl!, width: 200, height: 200,),borderRadius: BorderRadius.all(Radius.circular(30)),);
    } else {
      return ClipRRect(child: Image.asset(
        "assets/images/user.jpg",
        fit: BoxFit.fitWidth,
        width: 200,
        height: 200,
        ),borderRadius: BorderRadius.all(Radius.circular(30)),
      );
    }
  }
}