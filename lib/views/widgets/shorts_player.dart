import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShortsPlayer extends StatefulWidget {
  final String videoUrl;
  const ShortsPlayer(controller, {super.key, required this.videoUrl});

  @override
  State<ShortsPlayer> createState() => _ShortsPlayerState();
}

class _ShortsPlayerState extends State<ShortsPlayer> {
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    super.initState();
    videoPlayerController =
        VideoPlayerController.networkUrl(widget.videoUrl as Uri)
          ..initialize().then((value) {
            videoPlayerController.play();
            videoPlayerController.setVolume(1);
          });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(color: Colors.black),
      child: VideoPlayer(videoPlayerController),
    );
  }
}
