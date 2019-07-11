import 'package:chao_tpa/screens/my_service.dart';
import 'package:chao_tpa/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; //9.code send value to cloud เสร็จจากนี้ไปที่ไฟล์ my_service.dart

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String emailString, passwordString;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Method

  void mySnackBar(String messageString) {
    SnackBar snackBar = SnackBar(
      content: Text(messageString),
      duration: Duration(seconds: 8),backgroundColor: Colors.pink[300], // Set เวลาให้ Message อยู่ 8 วินาที
      action: SnackBarAction(
        label: 'X',textColor: Colors.white, //ให้มีข้อความกดปิดได้
        onPressed: () {},
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  //7.code send value to cloud
  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  //8.code send value to cloud
  Future<void> checkStatus() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if (firebaseUser != null) {
      moveToService();
    }
  }

// Login แล้วไปที่หน้า Service
  void moveToService() {
    var serviceRoute =
        MaterialPageRoute(builder: (BuildContext context) => MyService());
    Navigator.of(context)
        .pushAndRemoveUntil(serviceRoute, (Route<dynamic> route) => false);
  }

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
          hintText: 'emailyou@xxxx.com', // insert hint ให้ผู้ใช้งานเห็น
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please Fill Email';
          }
        },
        onSaved: (String value) {
          emailString = value;
        },
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
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please Fill Password';
          }
        },
        onSaved: (String value) {
          passwordString = value;
        },
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
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save(); //บันทึกการ login เข้าระบบ
          checkAuthen();
        }
      },
    );
  }

  Future<void> checkAuthen() async {
    print('Email=$emailString,Password=$passwordString');
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((resporne) {
      moveToService(); //ถ้า username & password ถูกต้องให้ไปที่หน้า my_service.dart
    }).catchError((respone) {
      String messageString = respone.message;
      print('Message=$messageString');
      mySnackBar(messageString);
    });
  }

  Widget signUpButton() {
    return RaisedButton(
      color: Colors.orange[200],
      child: Text('Sign UP'),
      onPressed: () {
        print('You Click Sign Up');
        // Create Route
        var registerRoute = MaterialPageRoute(
            builder: (BuildContext context) =>
                Register()); // คำสั่งไปยังหน้าที่คลิก ตรงนี้คือไปหน้า Register.dart และการสื่อสารระหว่างหน้าต้องใช้คำสั่ง BuildContext context เสมอ
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
      key: scaffoldKey,
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
        child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                showLogo(),
                showText(),
                emailText(),
                passwordText(),
                showButton(),
              ],
            )),
      ),
    );
  }
}
