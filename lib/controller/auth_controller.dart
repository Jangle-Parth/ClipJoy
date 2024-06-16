import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:clipjoy/constants.dart';
import 'package:clipjoy/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<File?> _pickedImage;
  File? get profilePhoto => _pickedImage.value;

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
      } else {
        Get.snackbar("Error Logging you in", "Please Fill all the feilds");
      }
    } catch (e) {
      Get.snackbar("Error Loggin in", e.toString());
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
}
