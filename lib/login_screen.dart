import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  VideoPlayerController? controller;
  @override
  void initState() {
    controller=VideoPlayerController.asset("assets/khary.mp4")..initialize().then((value) {
      setState(() {});
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Video App"),),
    body:  Column(children: [
      controller!.value.isInitialized? AspectRatio(aspectRatio: controller!.value.aspectRatio,
      child: VideoPlayer(controller!),
      ):Container()
    ],),
    floatingActionButton: FloatingActionButton(onPressed: (){
      controller!.value.isPlaying?
      controller!.pause():
      controller!.play();
    },child: Icon(Icons.play_arrow),),
    );
  }
}