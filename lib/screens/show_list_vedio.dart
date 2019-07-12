import 'dart:async';

import 'package:chao_tpa/models/pha_video_model.dart';
import 'package:chao_tpa/screens/play_video.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//ก่อนจะเขียนโปรแกรมไปตั้งค่า Database ที่ https://console.firebase.google.com/project/phagalleryth/database/firestore/data~2Fphavedio~2FsWfho0yk6dYCUhWml11z
// ไปทำการติดตั้งไฟล์  cloud_firestore: ^0.12.7 ที่ pubspec.yaml
// ที่ ancroid > app > build.gradle > ตรง dependencies {
// พิมพ์  implementation 'com.android.support:multidex:1.0.3' //import เพื่อให้ใช้งาน File Store ได้ เคสทำอัพโหลดวิดีโอ
// ตรง  defaultConfig {
// พิมพ์ multiDexEnabled true //import เพื่อให้ใช้งาน File Store ได้ เคสทำอัพโหลดวิดีโอ

class ShowListVideo extends StatefulWidget {
  @override
  _ShowListVideoState createState() => _ShowListVideoState();
}

class _ShowListVideoState extends State<ShowListVideo> {
  //Explicit
  Firestore fireStore = Firestore.instance;
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot>
      snapshots; //สร้างตัวแปรเพื่อเก็บ Array ของ Vedio ที่เราจะดึงมา
  List<PhaVideoModel> phaVideoModels =
      []; //ประกาศตัวแปร phaVideoModels ให้มีค่าเท่ากับศูนย์

  @override
  void initState() {
    super.initState();
    readFireStore();
  }

  //Method

  Future<void> readFireStore() async {
    CollectionReference collectionReference = fireStore.collection('phavedio');

    subscription = await collectionReference.snapshots().listen((response) {
      snapshots = response.documents;
      for (var snapshotdata in snapshots) {
        //ตั้งชื่อตัวแปรว่า snapshotdata

        String nameVedio = snapshotdata
            .data['Name']; //ชื่อ Name ต้องมีค่าเท่ากับฟิลใน database
        String detailVedio = snapshotdata
            .data['Detail']; //ชื่อ Detail ต้องมีค่าเท่ากับฟิลใน database
        String pathImage = snapshotdata
            .data['PathImage']; //ชื่อ PathImage ต้องมีค่าเท่ากับฟิลใน database
        String pathVideo = snapshotdata
            .data['PathVedio']; //ชื่อ PathVedio ต้องมีค่าเท่ากับฟิลใน database

        PhaVideoModel phaVideoModel =
            PhaVideoModel(nameVedio, detailVedio, pathImage, pathVideo);

        setState(() {
          phaVideoModels
              .add(phaVideoModel); //คำสั่ง Refresh หน้าจอเมื่อรับค่ามาแล้ว
        });

//print('nameVedio=$nameVedio');
//print('detailVedio=$detailVedio');
//print('pathImage=$pathImage');
//print('pathVideo=$pathVideo');
// เสร็จแล้วไปสร้าง Floder ใน lib ชื่อว่า medels และสร้างไฟล์ชื่อว่า pha_video_model.dart เสร็จแล้วไปที่ return Text('Show List Video'); เปลี่ยนค่า

      }
    });
  }

  Widget showImage(int index) {
    return Container(
      margin: EdgeInsets.all(5.0),
      height: 120.0,
      width: 180.0,
      child: Image.network(
        phaVideoModels[index].pathImage,
        fit: BoxFit
            .contain, //ให้ขนาดวีดีโอมีขนาดพอดีกับค่า height & width ที่ตั้งไว้
      ),
    );
  }

  Widget showText(int index) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              phaVideoModels[index].name,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[200]),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              phaVideoModels[index].detail,
            ),
          )
        ],
      ),
    );
  }

  Widget myDivider() {
    return Divider(
      height: 10.0,
      color: Colors.pink[100],
    );
  }

  @override
  Widget build(BuildContext context) {
    //return Text('Show List Video');
    return Container(
      alignment: Alignment.topLeft,
      child: ListView.builder(
        itemCount: phaVideoModels.length,
        itemBuilder: (context, int index) {
          return GestureDetector(
            child: Container(
                child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    showImage(index),
                    showText(index),
                  ],
                ),
                myDivider(),
              ],
            )
                // child: Text(phaVideoModels[index].name),
                ),
            onTap: () {
              //print('index=$index');

              var playROute = MaterialPageRoute(
                  builder: (BuildContext context) => PlayVedio(
                        phaVideoModel: phaVideoModels[index],
                      ));
              Navigator.of(context).push(playROute);
            },
          );
        },
      ),
    );
  }
}
