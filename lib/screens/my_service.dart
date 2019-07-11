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

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //Method
  Future <void> signOutAndExit() async{

await firebaseAuth.signOut().then((respone){
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
        title: Text('My Service'),
      ),
      body: Text('body'),
      drawer: myDrawerMenu(),
    );
  }
}
