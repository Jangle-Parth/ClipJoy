import 'package:clipjoy/controller/videocontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ShortsPlayer extends StatefulWidget {
  final String videoUrl;
  const ShortsPlayer({super.key, required this.videoUrl});

  @override
  State<ShortsPlayer> createState() => _ShortsPlayerState();
}

class _ShortsPlayerState extends State<ShortsPlayer> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  final VideoController _videoController = Get.find<VideoController>();
  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _videoListener() {
    if (_videoPlayerController.value.position >=
        _videoPlayerController.value.duration) {
      final nextVideo = _videoController.nextVideo;
      if (nextVideo != null) {
        _videoPlayerController.pause();
        _videoPlayerController.removeListener(_videoListener);
        _videoPlayerController.dispose();
        setState(() {
          _initializePlayer();
        });
      }
    }
  }

  void _initializePlayer() {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _initializeVideoPlayerFuture =
        _videoPlayerController.initialize().then((value) {
      _videoPlayerController.play();
      _videoPlayerController.setVolume(1);
      _videoPlayerController.addListener(_videoListener);
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _videoPlayerController.value.aspectRatio,
            child: VideoPlayer(_videoPlayerController),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
