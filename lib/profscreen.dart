// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fanpage_app/users.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // TODO: Implement modal popup with text box feature
  void adminText() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SearchScreen()));
    print("Tester");
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
          Text("Build Modal"),
        ])),
        floatingActionButton: FloatingActionButton(
          onPressed: adminText,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
