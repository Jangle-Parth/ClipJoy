import 'dart:math';

import 'package:clipjoy/constants.dart';
import 'package:clipjoy/controller/videocontroller.dart';
import 'package:clipjoy/views/widgets/customicon.dart';
import 'package:clipjoy/views/widgets/shorts_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  final String? videoUrl;
  const HomeScreen({super.key, this.videoUrl});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  final VideoController _videoController = Get.put(VideoController());
  late Widget page;

  @override
  void initState() {
    super.initState();
    page = pages[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              if (index == 2) {
                final nextvideo = _videoController.nextVideo;
                if (nextvideo != null) {
                  page = ShortsPlayer(videoUrl: nextvideo.videoUrl);
                }
              } else {
                pageIndex = index;
                page = pages[pageIndex];
              }
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: backgroundColor,
          selectedItemColor: Colors.red[200],
          unselectedItemColor: Colors.white,
          currentIndex: pageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 30), label: "Search"),
            BottomNavigationBarItem(icon: CustomIcon(), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 30), label: "Profile"),
          ]),
      body: Center(child: page),
    );
  }
}
