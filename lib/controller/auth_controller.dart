import 'dart:io';
import 'package:clipjoy/views/screens/auth/login_screen.dart';
import 'package:clipjoy/views/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';

import 'package:clipjoy/constants.dart';
import 'package:clipjoy/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  late Rx<User?> _user;
  static AuthController instance = Get.find();
  late Rx<File?> _pickedImage;
  File? get profilePhoto => _pickedImage.value;
  User? get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    _user = Rx<User?>(firebaseAuth.currentUser);
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile Picture', 'Succesfull');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        Get.snackbar("Error Loggin you in", "Please Fill all the feilds");
      }
    } catch (e) {
      Get.snackbar("Error Loggin in", e.toString());
    }
  }

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  Future<void> registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty && image != null) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        String downloadUrl = await _uploadToStorage(image);
        MyUser user = MyUser(
          name: username,
          profilePhoto: downloadUrl,
          email: email,
          uid: cred.user!.uid,
        );
        await firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar("Error Creating Account", "Pls Enter all Feild Correctly");
      }
    } catch (e) {
      Get.snackbar("Error Creating Account", e.toString());
    }
  }

  signOut() async {
    await firebaseAuth.signOut();
  }
}
