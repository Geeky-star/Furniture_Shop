import 'package:flutter/material.dart';
import 'package:furniture_app/screens/auth.dart';
import 'package:furniture_app/screens/home.dart';
import 'package:furniture_app/screens/register.dart';
import 'package:furniture_app/widgets/text.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: Image.asset("assets/login.png")),
            Positioned(
              top: 100,
              left: 100,
              child: Text("Login to Shop",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            ),
            Positioned(
              top: 230,
              left: 15,
              right: 6,
              child: TextField(
                controller: _email,
                decoration:
                    InputDecoration(hintText: "Email", icon: Icon(Icons.email)),
              ),
            ),
            Positioned(
              top: 300,
              left: 15,
              right: 6,
              child: TextField(
                controller: _password,
                decoration: InputDecoration(
                    hintText: "Password", icon: Icon(Icons.lock)),
              ),
            ),
            Positioned(
              top: 400,
              left: 160,
              child: RaisedButton(
                onPressed: () async {
                  bool shouldNavigate =
                      await signIn(_email.text, _password.text);
                  if (shouldNavigate) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                  } else {
                    return CircularProgressIndicator();
                  }
                },
                color: Colors.black,
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Positioned(
                top: 460,
                left: 190,
                child: Text(
                  "Or",
                  style: Textstyle.normalheading,
                )),
            Positioned(
              top: 500,
              left: 160,
              child: RaisedButton(
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.black,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ));
                },
              ),
            ),
            Positioned(
                top: 550,
                left: 80,
                child: Text(
                  "Don't have account? Register",
                  style: Textstyle.normalheading,
                ))
          ],
        ),
      ),
    );
  }
}
