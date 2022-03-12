// ignore_for_file: prefer_const_constructors, unnecessary_new
import 'dart:async';

import 'package:fanpage_app/loginscreen.dart';
import 'package:fanpage_app/profscreen.dart';
import 'package:fanpage_app/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => RegistrationScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: const [
            Color.fromARGB(255, 233, 80, 200),
            Color.fromARGB(255, 199, 64, 59),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: const Text(
              'Fanpage App',
              style: TextStyle(fontFamily: 'Lemonmilk', color: Colors.white),
            )),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'images/header.jpg',
            height: 120,
            width: 140,
          ),
          SizedBox(height: 75),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.amber.shade400),
          )
        ])),
      ),
    );
  }
}
