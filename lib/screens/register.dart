import 'package:flutter/material.dart';
import 'package:furniture_app/screens/auth.dart';
import 'package:furniture_app/screens/home.dart';
import 'package:furniture_app/screens/login.dart';
import 'package:furniture_app/widgets/text.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
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
                  child: Image.asset("assets/login1.png")),
              Positioned(
                top: 100,
                left: 70,
                child: Text("Register to Shop",
                    style:
                        TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              ),
              Positioned(
                top: 230,
                left: 15,
                right: 6,
                child: TextField(
                  controller: _email,
                  decoration: InputDecoration(
                      hintText: "Email", icon: Icon(Icons.email)),
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
                        await register(_email.text, _password.text);
                    if (shouldNavigate != null) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ));
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                  color: Colors.black,
                  child: Text(
                    "Register",
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
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ));
                    }),
              ),
              Positioned(
                  top: 550,
                  left: 80,
                  child: Text(
                    "Already have an account? Login",
                    style: Textstyle.normalheading,
                  ))
            ],
          ),

          /*Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: TextField(
                  controller: _password,
                  decoration: InputDecoration(hintText: "Password"),
                ),
              ),
              RaisedButton(
                child: Text("Register"),
                color: Colors.white,
                onPressed: () async {
                  bool shouldNavigate =
                      await register(_email.text, _password.text);
                  if (shouldNavigate != null) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
      ),
      */
        ));
  }
}
