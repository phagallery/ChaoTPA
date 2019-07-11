import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
//10.Start code send value to cloud
  //Explicit
  String nameString = '';

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //Method
  Widget showTitleAppBar() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text('My Service'),
          ),
          Container(margin: EdgeInsets.only(top: 10.0), //กำหนดระยะห่างระหว่างคำว่า My Service และ 'Login by=$nameString'
            alignment: Alignment.topLeft,
            child: Text(
              'Login by = $nameString',
              style: TextStyle(
                  fontSize: 14.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    findName();
  }

  Future<void> findName() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    setState(() {
      nameString = firebaseUser.displayName;
    });
    print('name=$nameString');
  }

  Future<void> signOutAndExit() async {
    await firebaseAuth.signOut().then((respone) {
      exit(0);
    });
  }

  Widget showApp() {
    return Text(
      'Pha Gallery',
      style: TextStyle(fontSize: 24.0, color: Colors.pink[300]),
    );
  }

  Widget showLogo() {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget myDrawerMenu() {
    //hamber icon เมนูย่อยมุมซ้ายบน
    return Drawer(
      child: ListView(
        //คำสั่งให้มี scrollbar ได้
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.pink[100],
            ),
            child: Container(
              child: Column(
                children: <Widget>[
                  showLogo(),
                  showApp(),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              size: 36.0,
            ),
            title: Text(
              'Sign Out & Exit',
              style: TextStyle(
                color: Colors.blue[300],
                fontSize: 18.0,
              ),
            ),
            onTap: () {
              signOutAndExit();
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

//10.End code send value to cloud

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: showTitleAppBar(),backgroundColor: Colors.pink[300],
      ),
      body: Text('body'),
      drawer: myDrawerMenu(),
    );
  }
}
