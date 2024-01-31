import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project02_hackloop/Screens/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        home: const SignIn());
  }
}
