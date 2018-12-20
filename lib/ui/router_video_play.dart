import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayPage extends StatefulWidget {

  final String videoUrl;

  VideoPlayPage(this.videoUrl);

  @override
  _VideoPlayPageState createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Center(
        child: Chewie(
           VideoPlayerController.network(
              'https://flutter.github.io/assets-for-api-docs/videos/butterfly.mp4'
          ),
          aspectRatio: 16 / 9,
          autoPlay: true,
          looping: true,
        ),
      ),
    );
  }
}
