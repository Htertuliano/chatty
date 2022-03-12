// ignore_for_file: prefer_const_constructors

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
    return const MaterialApp(
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController search = TextEditingController();
  var searchResult;
  bool isLoading = false;
  bool haveUserSearched = false;

  getUser(String username) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .where("UID", isEqualTo: username)
        .get();
  }

  initiateSearch() async {
    await getUser(search.text).then((val) {
      setState(() {
        searchResult = val;
      });
    });
  }

  Widget searchList() {
    return searchResult != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchResult.docs.length,
            itemBuilder: (context, index) {
              return searchTile(
                username: searchResult.docs[0]['UID'],
                userfname: searchResult.docs[0]['fName'],
              );
            })
        : Container();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFDCC7BE),
        appBar: AppBar(
            backgroundColor: Color(0xFF145C9E),
            centerTitle: true,
            title: const Text(
              'Have a Search Then',
              style: TextStyle(fontFamily: 'Lemonmilk', color: Colors.white),
            )),
        body: Container(
            child: Column(
          children: [
            Container(
              color: Color(0xFFCBB9A8),
              padding: EdgeInsets.symmetric(horizontal: 34, vertical: 18),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: search,
                    decoration: InputDecoration(
                      hintText: "Search username...",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
                      getUser(search.text).then((val) {
                        print(val.toString());
                      });
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      padding: EdgeInsets.all(10),
                      child: Image.asset('/images/search.png'),
                    ),
                  ),
                ],
              ),
            ),
            searchList(),
          ],
        )));
  }
}

class searchTile extends StatelessWidget {
  final String username;
  final String userfname;

  searchTile({required this.username, required this.userfname});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                username,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                userfname,
                style: TextStyle(color: Colors.white, fontSize: 16),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              // sendMessage(username);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 172, 109),
                  borderRadius: BorderRadius.circular(24)),
              child: Text(
                "Chat 'em",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
