// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage_app/loginscreen.dart';
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
      home: RegistrationScreen(),
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
      body: RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Log-in function

  late bool _succcess;
  late String userInfo;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _fnController = TextEditingController();
  final TextEditingController _lnController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _emController = TextEditingController();

  void register() async {
    UserCredential newUser = await fAuth.createUserWithEmailAndPassword(
        email: _emController.text, password: _pwController.text);
    User? updateUser = fAuth.currentUser;

    CollectionReference storageRef =
        FirebaseFirestore.instance.collection("Users");
    //String role = fAuth.currentUser.Role = "Customer";
    storageRef.add({
      'fName': _fnController.text,
      'email': _emController.text,
      'Role': "Customer",
      'Password': _pwController.text,
      'UID': _idController.text
    });

    _fnController.text = "";
    _lnController.text = "";
    _pwController.text = "";
    _idController.text = "";
    _emController.text = "";

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));

    return;
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
                prefixIcon:
                    Icon(Icons.mail_outlined, color: Colors.amberAccent),
              ),
            ),
            TextField(
              controller: _idController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "User ID Needed",
                prefixIcon: Icon(Icons.person_add, color: Colors.amberAccent),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            TextField(
              controller: _fnController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "User First Name Needed",
                prefixIcon: Icon(Icons.perm_contact_cal_sharp,
                    color: Colors.amberAccent),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            TextField(
              controller: _lnController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "User Last Name Needed",
                prefixIcon: Icon(Icons.perm_contact_cal_sharp,
                    color: Colors.amberAccent),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            TextField(
                controller: _pwController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password (At Least 6 Characters)",
                  prefixIcon:
                      Icon(Icons.lock_outline, color: Colors.amberAccent),
                )),
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
                      register();
                    },
                    child: Text("Register",
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
