import 'package:clipjoy/constants.dart';
import 'package:clipjoy/models/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);
  List<Video> get videoList => _videoList.value;
  int _currentVideoIndex = 0;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(
        firestore.collection('videos').snapshots().map((QuerySnapshot query) {
      List<Video> retVal = [];
      for (var element in query.docs) {
        retVal.add(
          Video.fromSnamp(element),
        );
      }
      retVal.shuffle();
      return retVal;
    }));
  }

  Video? get nextVideo {
    if (_videoList.value.isEmpty) return null;
    _currentVideoIndex = (_currentVideoIndex + 1) % _videoList.value.length;
    return _videoList.value[_currentVideoIndex];
  }

  likeVideo(String id) async {
    DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
    var uid = authController.user?.uid;
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
