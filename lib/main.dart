import 'package:chao_tpa/screens/authen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(debugShowCheckedModeBanner: false, //คำสั่งปิด Banner Debug มุมขวาบน
      home: Authen(),
    );
  }
}
