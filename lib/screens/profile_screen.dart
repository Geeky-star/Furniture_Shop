import 'package:flutter/material.dart';
import 'package:furniture_app/widgets/text.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(left: 100.0),
              child: Text("My Account",style: Textstyle.heading,),
            )
          ],
        )
      ),
    );
  }
}
