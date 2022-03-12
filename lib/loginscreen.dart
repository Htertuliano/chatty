// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage_app/profscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

final fAuth = FirebaseAuth.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Log-in function

  late bool _succcess;
  late String userInfo;
  final TextEditingController _emController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  void signin() async {
    User? user;
    try {
      UserCredential userCredential = await fAuth.signInWithEmailAndPassword(
          email: _emController.text, password: _pwController.text);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        _emController.text = "";
        _pwController.text = "";
        print("No User Found");
        rethrow;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.0,
            ),
            TextField(
              controller: _emController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "User Email Needed",
                prefixIcon: Icon(Icons.mail_outline, color: Colors.amberAccent),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            TextField(
              controller: _pwController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "User Password Needed",
                prefixIcon:
                    Icon(Icons.lock_outlined, color: Colors.amberAccent),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Have you forgotten your password?',
              style: TextStyle(color: Colors.amberAccent),
            ),
            SizedBox(
              height: 90.0,
            ),
            Container(
                width: double.infinity,
                child: RawMaterialButton(
                    fillColor: Color(0xff505168),
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () async {
                      signin();
                    },
                    child: Text("Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        )))),
          ],
        ),
      ),
    );
  }
}
