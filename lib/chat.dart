// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage_app/loginscreen.dart';
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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chats",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Chats"),
        ),
        body: MyForm(),
      ),
    );
  }
}

class MyForm extends StatelessWidget {
  MyForm({Key? key}) : super(key: key);

  TextEditingController _message = TextEditingController();

  String addMessage(String message) {
    CollectionReference storageRef =
        FirebaseFirestore.instance.collection("Chatroom");

    storageRef.add({
      'Message': _message.text,
    });
    _message.text = '';
    return _message.text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              onSubmitted: addMessage,
              controller: _message,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Chat em',
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Text(
            addMessage(_message.text),
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
