import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; //1.code send value to cloud

class Register extends StatefulWidget {
  //สร้าง class โดยพิมพ์ stl เลือก flutter stateful Widget

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Explicit

  final formKey = GlobalKey<
      FormState>(); //เป็นการประกาศตัวแปรเพื่อเก็บค่าจาก Form ได้หลายค่า
  String nameString, emailString, passwordString;
  FirebaseAuth firebaseAuth =
      FirebaseAuth.instance; //2.code send value to cloud

  //Method
  Widget uploadButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        print('Click Upload');
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print(
              'Name= $nameString,Email=$emailString,Password=$passwordString');
          registerFirebase(); //4.code send value to cloud
        }
      },
    );
  }

  //3.Start Trad -code send value to cloud
  //void ไม่มีการ return ค่ากลับ
  //response โยนกลับมาแบบ object
  Future<void> registerFirebase() async {
    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      print('Register Success');
    }).catchError((response) {
      //กรณีมีชื่อใน database แล้ว
      print('Error=${response.toString()}');

      String title = response.code; // error ที่มาจาก programe
      String message = response.message;
      myAleart(title, message);
    });
  }
  //End Trad -code send value to cloud

//5.code send value to cloud
  void myAleart(String titleString, String messageString) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titleString,style: TextStyle(color: Colors.red[300]),),
          content: Text(messageString),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
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
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please fill FirstName & LastName!!';
        }
      },
      onSaved: (String value) {
        nameString = value;
      },
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
      validator: (String value) {
        if (!((value.contains('@')) && (value.contains('.')))) {
          //เครื่องหมาย ! คือเงื่อนไขตรงกันข้าม ในที่นี้คือ ถ้าไม่มีเครื่องหมาย @ กับ . ให้ทำอะไร
          return 'Email Address incorrect Format!!';
        }
      },
      onSaved: (String value) {
        emailString = value;
      },
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
      validator: (String value) {
        if (value.length <= 5) {
          return 'Password Leat 6 Charactor!!';
        }
      },
      onSaved: (String value) {
        passwordString = value;
      },
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
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                nameText(),
                emailnameText(),
                passwordText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
