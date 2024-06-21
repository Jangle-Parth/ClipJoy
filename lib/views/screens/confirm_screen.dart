import 'dart:io';

import 'package:clipjoy/controller/upload_video_controller.dart';
import 'package:clipjoy/views/screens/home_screen.dart';
import 'package:clipjoy/views/widgets/text_input_feild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmScreen(
      {super.key, required this.videoFile, required this.videoPath});

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  TextEditingController _songController = TextEditingController();
  TextEditingController _captionController = TextEditingController();
  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
      controller.initialize();
      controller.play();
      controller.setVolume(1);
      controller.setLooping(true);
    });
  }

  @override
  void dispose() {
    controller.pause();
    controller.dispose();
    _songController.dispose();
    _captionController.dispose();
    super.dispose();
  }

  Future<void> uploadVideo(UploadVideoController uploadVideoController,
      String songName, String caption, String videoPath) async {
    setState(() {
      _isLoading = true;
    });
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    await uploadVideoController.uploadVideo(songName, caption, videoPath);
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop(); // Close the loading dialog

    _showCustomToast(context, 'Video added successfully!');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }

  void _showCustomToast(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50.0,
        left: MediaQuery.of(context).size.width * 0.2,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  late VideoPlayerController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: VideoPlayer(controller),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputFeild(
                      controller: _songController,
                      labelText: "Song Name",
                      isObscure: false,
                      icon: Icons.music_note,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputFeild(
                      controller: _captionController,
                      labelText: " Caption",
                      isObscure: false,
                      icon: Icons.closed_caption,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await uploadVideo(
                            uploadVideoController,
                            _songController.text,
                            _captionController.text,
                            widget.videoPath);
                      },
                      child: const Text(
                        "Upload!",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
