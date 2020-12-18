import 'package:flutter/material.dart';

class NewSnackBar extends StatefulWidget {
  @override
  _NewSnackBarState createState() => _NewSnackBarState();
}

class _NewSnackBarState extends State<NewSnackBar> {

   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}