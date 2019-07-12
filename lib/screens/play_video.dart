import 'package:chao_tpa/models/pha_video_model.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class PlayVedio extends StatefulWidget {
  final PhaVideoModel phaVideoModel;
  PlayVedio({Key key, this.phaVideoModel}) : super(key: key);

  @override
  _PlayVedioState createState() => _PlayVedioState();
}

class _PlayVedioState extends State<PlayVedio> {
//Explicit
  PhaVideoModel phaVideoModel;
  ChewieController chewieController;
  VideoPlayerController videoPlayController;
  String urlVideo;

//Method

  @override
  void initState() {
    super.initState();

    setState(() {
      phaVideoModel = widget.phaVideoModel;
      urlVideo = phaVideoModel.pathVideo;
      print('ur=$urlVideo');

      videoPlayController = VideoPlayerController.network(urlVideo);
      chewieController = ChewieController(
        videoPlayerController: videoPlayController,
        aspectRatio: 3 / 2,
        autoPlay: true,
        looping: true,
      );
    });
  }
  @override
  void dispose() {
    super.dispose();
    videoPlayController.dispose();
    chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Play Vedio'),
        title: Text('You Play ${phaVideoModel.name}'),
      ),
      body: Center(
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }
}
// ก่อนเขียนโค้ด Play Vedio ให้ทำการ install ตัว chewie: ^0.9.7 นี้ก่อน ที่เว็บ https://pub.dev/packages/chewie เพื่อ install ตัว Streaming
// install video_player: ^0.10.1+3 ที่เว็บ https://pub.dev/packages/video_player
