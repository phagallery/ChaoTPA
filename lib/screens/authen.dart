import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explicit

  // Method
  Widget showLogo() {
    return Container(
      width: 150.0,
      // height: 120.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showText() {
    return Text(
      'Chao TPA',
      style: TextStyle(
        fontSize: 30.0,
        color: Colors.brown[800],
        fontWeight: FontWeight.bold,
        fontFamily: 'Pacifico'
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 60.0),
        child: Column(
          children: <Widget>[
            showLogo(),
            showText(),
          ],
        ),
      ),
    );
  }
}
