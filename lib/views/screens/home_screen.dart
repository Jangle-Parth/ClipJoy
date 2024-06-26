import 'package:clipjoy/constants.dart';
import 'package:clipjoy/controller/videocontroller.dart';
import 'package:clipjoy/views/widgets/customicon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  final VideoController _videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              pageIndex = index;
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
      body: Center(child: pages[pageIndex]),
    );
  }
}
