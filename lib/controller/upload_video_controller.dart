import 'dart:io';

import 'package:clipjoy/constants.dart';
import 'package:clipjoy/models/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  _compressVideo(String videoPath) async {
    final compressedvideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);

    return compressedvideo?.file;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);
    File? compressedVideo = await _compressVideo(videoPath);
    if (compressedVideo == null) {
      Get.snackbar("Error Uploading Video", "Compressed Video Returened null");
    }
    UploadTask uploadTask = ref.putFile(compressedVideo!);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    File? thumbnail = await _getThumbnail(videoPath);
    if (thumbnail == null) {
      Get.snackbar("Error Occured", "Error in Capturing Thumbnail");
    }
    UploadTask uploadTask = ref.putFile(thumbnail!);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<File?> _getThumbnail(String videPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videPath);
    return thumbnail;
  }

  Future<void> uploadVideo(
      String songName, String caption, String videoPath) async {
    try {
      var user = firebaseAuth.currentUser;
      if (user == null) {
        Get.snackbar("Error Occured", "User is not logged in");
      }
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();
      var allDocs = await firestore.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);
      String thumbnail = await _uploadImageToStorage("Video $len", videoPath);

      Video video = Video(
          username: (userDoc.data()! as Map<String, dynamic>)['name'],
          uid: uid,
          id: "Video $len",
          likes: [],
          commentCount: 0,
          shareCount: 0,
          songname: songName,
          caption: caption,
          videoUrl: videoUrl,
          thumbnail: thumbnail,
          profilePhoto:
              (userDoc.data()! as Map<String, dynamic>)['profilePhoto']);

      await firestore
          .collection('videos')
          .doc('Video $len')
          .set(video.toJson());
    } catch (e) {
      Get.snackbar("Error Uploading Video", e.toString());
    }
  }
}
