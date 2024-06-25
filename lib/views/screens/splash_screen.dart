import 'dart:async';

import 'package:clipjoy/controller/auth_controller.dart';
import 'package:clipjoy/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _authController = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      _authController.onReady();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black54,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 64,
                backgroundImage: AssetImage("assets/splash.png"),
                backgroundColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
