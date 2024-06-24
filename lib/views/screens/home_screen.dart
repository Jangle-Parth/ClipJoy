import 'dart:math';

import 'package:clipjoy/constants.dart';
import 'package:clipjoy/views/widgets/customicon.dart';
import 'package:clipjoy/views/widgets/shorts_player.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String? videoUrl;
  const HomeScreen({super.key, this.videoUrl});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  int randomIndex = 1;
  Widget page = pages[0];
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              print(widget.videoUrl);
              if (widget.videoUrl == null) {
                pageIndex = index;
                page = pages[pageIndex];
              } else {
                print(widget.videoUrl);
                page = ShortsPlayer(videoUrl: widget.videoUrl!);
                print(page);
              }
              print(page);
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
                icon: Icon(Icons.message, size: 30), label: "Message"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 30), label: "Profile"),
          ]),
      body: Center(child: page),
    );
  }
}
