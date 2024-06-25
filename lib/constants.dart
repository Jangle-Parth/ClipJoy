import 'package:clipjoy/controller/auth_controller.dart';
import 'package:clipjoy/views/screens/add_video_screen.dart';
import 'package:clipjoy/views/screens/profileScreen.dart';
import 'package:clipjoy/views/screens/search_screen.dart';
import 'package:clipjoy/views/screens/video_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;
var authController = AuthController.instance;

List pages = [
  VideoScreen(),
  SearchScreen(),
  const AddVideoScreen(),
  ProfileScreen(uid: authController.user!.uid)
];
