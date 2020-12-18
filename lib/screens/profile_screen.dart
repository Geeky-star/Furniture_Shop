import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/screens/auth.dart';
import 'package:furniture_app/widgets/text.dart';

class ProfileScreen extends StatefulWidget {
  final String email;

  ProfileScreen({this.email});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text(
          "My Account",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Container(
          child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Text(
              "You are User: ",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(_user.uid),
          )
        ],
      )),
    );
  }
}
