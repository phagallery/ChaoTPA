import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  //สร้าง class โดยพิมพ์ stl เลือก flutter stateful Widget

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Explicit

  //Method

  Widget uploadButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {},
    );
  }

// ช่องกรอก Name & LastName
  Widget nameText() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Name : ',
        labelStyle: TextStyle(
          color: Colors.pink[300],
          fontSize: 26.0,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'FirstName & LastName',
        helperStyle: TextStyle(
          color: Colors.grey[300],
          fontSize: 14.0,
          fontStyle: FontStyle.italic,
        ),
        icon: Icon(
          Icons.account_circle,
          size: 36.0,
          color: Colors.pink,
        ), // Default Size = 24.0
      ),
    );
  }

// ช่องกรอก Email
  Widget emailnameText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email : ',
        labelStyle: TextStyle(
          color: Colors.pink[300],
          fontSize: 26.0,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'Email Address',
        helperStyle: TextStyle(
          color: Colors.grey[300],
          fontSize: 14.00,
          fontStyle: FontStyle.italic,
        ),
        icon: Icon(
          Icons.email,
          size: 36.0,
          color: Colors.pink,
        ), // Default Size = 24.0
      ),
    );
  }

// ช่องกรอก Password
  Widget passwordText() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password : ',
        labelStyle: TextStyle(
          color: Colors.blue[300],
          fontSize: 26.0,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'More 6 Charactor',
        helperStyle: TextStyle(
          color: Colors.grey[300],
          fontSize: 14.00,
          fontStyle: FontStyle.italic,
        ),
        icon: Icon(
          Icons.lock,
          size: 36.0,
          color: Colors.blue[300],
        ), // Default Size = 24.0
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false, //ปิดแป้นพิมพ์ไม่ให้ชน textbox
        appBar: AppBar(
          actions: <Widget>[uploadButton()],
          backgroundColor: Colors.pink[200],
          title: Text('Register'),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 60.0),
          alignment: Alignment.topCenter,
          child: Container(
            width: 250.0,
            child: Column(
              children: <Widget>[nameText(), emailnameText(), passwordText()],
            ),
          ),
        ));
  }
}
