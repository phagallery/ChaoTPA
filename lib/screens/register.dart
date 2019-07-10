import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  //สร้าง class โดยพิมพ์ stl เลือก flutter stateful Widget
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),body: Text('body'),
    );
  }
}


