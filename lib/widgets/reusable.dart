import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:project02_hackloop/utils/color.dart';

Image logoWidget(String imageName, double x, double y) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: x,
    height: y,
    color: toColor("d4d4d4"),
  );
}

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white.withOpacity(0.9),
    cursorWidth: 2,
    cursorHeight: 20,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelText: text,
      labelStyle: TextStyle(
          color: Colors.white.withOpacity(0.6),
          fontWeight: FontWeight.bold,
          fontSize: 16),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.black.withOpacity(0.1),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Image ImageWidget(String imageName, double x, double y) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: x,
    height: y,
  );
}

Container uiButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: 500,
    height: 50,
    margin: const EdgeInsets.fromLTRB(30, 10, 30, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Color.fromARGB(255, 214, 214, 214);
            }
            return Color.fromARGB(255, 212, 212, 212);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}

class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool isThumbsUp = true;

  void toggleThumbsUp() {
    setState(() {
      isThumbsUp = !isThumbsUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return newcard(context, 'Title', toggleThumbsUp);
  }
}

Container newcard(BuildContext context, String title, Function onTap,
    {bool isThumbsUp = false}) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.85,
    child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: toColor("d4d4d4"),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                "$title",
                style: TextStyle(color: toColor("111111"), fontSize: 20),
              ),
              IconButton(
                onPressed: () => onTap(),
                icon: Icon(
                  isThumbsUp
                      ? Icons.thumb_up
                      : Icons
                          .thumb_down_alt_outlined, // Change icon based on state
                  size: 22,
                  color: isThumbsUp
                      ? Color(0xFF16A349)
                      : Color.fromARGB(
                          244, 150, 36, 36), // Change color based on state
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

fadeMeIn(Widget wid, double delay) {
  return Animate(
    effects: [FadeEffect(delay: delay.ms, begin: 0)],
    child: wid,
  );
}

Widget buildImage(String imageUrl) {
  return Image.network(imageUrl, width: 200, height: 200, fit: BoxFit.cover);
}

getUsername() {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser = auth.currentUser;
  String username = currentUser?.email ?? 'Login Error';
  username = username.substring(0, 10);
  return username;
}

AlertDialog alertMe(BuildContext context, String title, actions, contents) {
  return AlertDialog(
    actions: actions,
    contentPadding: EdgeInsets.all(20),
    content: contents,
    title: Text(title),
  );
}

QrImageView genQR(String data) {
  return QrImageView(
    data: data,
    version: QrVersions.auto,
    size: 120.0,
    gapless: false,
    backgroundColor: Colors.white.withOpacity(0.1),
    eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.square, color: toColor("d4d4d4")),
    dataModuleStyle: QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.circle, color: toColor("d4d4d4")),
    errorStateBuilder: (context, error) {
      return Center(
        child: Text(
          'Error: $error',
          style: TextStyle(fontSize: 18),
        ),
      );
    },
  );
}

class DownloadAndDisplayImage extends StatefulWidget {
  @override
  _DownloadAndDisplayImageState createState() =>
      _DownloadAndDisplayImageState();
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
    try {
      final Reference imageRef =
          await storage.ref().child('userprof/$username.jpg');
      final String url = await imageRef.getDownloadURL();
      setState(() {
        imageUrl = url;
      });
    } on FirebaseException catch (e) {
      print("exception $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return ClipRRect(
        child: Image.network(
          imageUrl!,
          width: 200,
          height: 200,
        ),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      );
    } else {
      return ClipRRect(
        child: Image.asset(
          "assets/images/user.jpg",
          fit: BoxFit.fitWidth,
          width: 200,
          height: 200,
        ),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      );
    }
  }
}

int convToExpence(String a) {
  int num1 = 0;
  try {
    num1 = int.parse(a);
  } catch (e) {
    a = a.toLowerCase();
    num1 = a.codeUnitAt(0) - 87;
  }
  return num1 * 10;
}

Card expenceCard(
  BuildContext context,
  String title,
) {
  return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: toColor("d4d4d4"),
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 45,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Text(
            title,
            style: TextStyle(
                color: toColor("666666"),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
      ));
}

Card inputCard(String title, Function onTap, TextEditingController controller,
    String meal) {
  return Card(
    color: Colors.black.withOpacity(0.1),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  child: TextField(
                    controller: controller,
                    cursorColor: toColor("d4d4d4"),
                    style: TextStyle(color: toColor("d4d4d4")),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.05),
                      labelStyle: TextStyle(color: toColor("d4d4d4")),
                      labelText: "$title: $meal",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0, color: Colors.black.withOpacity(0.05)),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onSubmitted: (str) {
                      if (str != '') {
                        onTap();
                        controller.clear();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

String convHrToMeal(int hr) {
  if (hr < 11) {
    return "breakfast";
  } else if (hr < 16) {
    return "lunch";
  } else if (hr < 19) {
    return "snacks";
  } else {
    return "dinner";
  }
}
