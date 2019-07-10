import 'package:chao_tpa/screens/register.dart';
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
      'Pha Gallery',
      style: TextStyle(
          fontSize: 30.0,
          color: Colors.brown[800],
          fontWeight: FontWeight.bold,
          fontFamily: 'Pacifico'),
    );
  }

  Widget emailText() {
    return Container(
      width: 250.0,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress, //เพิ่มตัวช่วยให้มี @
        decoration: InputDecoration(
            labelText: 'Email : ',
            hintText: 'Emailyou@xxxx.com'), // insert hint ให้ผู้ใช้งานเห็น
      ),
    );
  }

  Widget passwordText() {
    return Container(
      width: 250.0,
      child: TextFormField(
        obscureText: true, // Set Password ให้เป็น *******
        decoration: InputDecoration(
          labelText: 'Password :',
          hintText: 'More 6 Charactor',
        ),
      ),
    );
  }

  Widget signInButton() {
    return RaisedButton(
      color: Colors.orange[900],
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {},
    );
  }

  Widget signUpButton() {
    return RaisedButton(
      color: Colors.orange[200],
      child: Text('Sign UP'),
      onPressed: () {
        print('You Click Sign Up');
        // Create Route
        var registerRoute = 
        MaterialPageRoute(builder: (BuildContext context) =>Register()); // คำสั่งไปยังหน้าที่คลิก ตรงนี้คือไปหน้า Register.dart และการสื่อสารระหว่างหน้าต้องใช้คำสั่ง BuildContext context เสมอ
                Navigator.of(context).push(registerRoute); // Link go Register Page
      },
    );
  }

  Widget mySizeBox() {
    return SizedBox(
      width: 8.0,
    );
  }

  Widget showButton() {
    return Container(
      width: 250.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: signInButton(),
          ),
          mySizeBox(),
          Expanded(
            child: signUpButton(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false, //อนุญาตให้ keyboard ทับ widget ได้
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.white, Colors.pink[200]],
            radius: 2.0, //จำนวนวงกลมที่ต้องการให้แสดงแสงสว่าง
            center: Alignment
                .topCenter, // จุดที่ให้แสงสว่างแสดง topCenter ด้านบน , Center ตรงกลาง
          ), //Set สี แบบ Gradient
        ), //color: Colors.yellow,
        padding: EdgeInsets.only(top: 60.0),
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            showLogo(),
            showText(),
            emailText(),
            passwordText(),
            showButton(),
          ],
        ),
      ),
    );
  }
}
