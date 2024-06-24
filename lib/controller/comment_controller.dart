import 'package:clipjoy/constants.dart';
import 'package:clipjoy/models/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  final Rx<List<Comments>> _comments = Rx<List<Comments>>([]);
  List<Comments> get comments => _comments.value;

  String _postId = "";
  updatePostId(String id) {
    _postId = id;
    getComment();
  }

  getComment() async {
    _comments.bindStream(firestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Comments> retValue = [];
      for (var element in query.docs) {
        retValue.add(Comments.fromSnap(element));
      }
      return retValue;
    }));
  }

  postComment(String commmentText) async {
    try {
      if (commmentText.isNotEmpty) {
        DocumentSnapshot userDoc = await firestore
            .collection("users")
            .doc(authController.user?.uid)
            .get();
        var allDocs = await firestore
            .collection("videos")
            .doc(_postId)
            .collection("comments")
            .get();
        int len = allDocs.docs.length;
        Comments comment = Comments(
            datePublished: DateTime.now(),
            username: (userDoc.data()! as dynamic)['name'],
            comment: commmentText.trim(),
            likes: [],
            profilePhoto: (userDoc.data()! as dynamic)['profilePhoto'],
            uid: authController.user!.uid,
            id: 'Comment $len');
        await firestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc('Comment $len')
            .set(comment.toJson());
        DocumentSnapshot doc =
            await firestore.collection('videos').doc(_postId).get();
        await firestore.collection("comments").doc(_postId).get();
        firestore.collection('videos').doc(_postId).update(
            {'commentCount': (doc.data()! as dynamic)['commentCount'] + 1});
      }
    } catch (e) {
      Get.snackbar("Error Occured", e.toString());
    }
  }

  likeComment(String id) async {
    var uid = authController.user?.uid;
    DocumentSnapshot doc = await firestore
        .collection("videos")
        .doc(_postId)
        .collection("comments")
        .doc(id)
        .get();

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firestore
          .collection("videos")
          .doc(_postId)
          .collection("comments")
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid])
      });
    }
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firestore
          .collection("videos")
          .doc(_postId)
          .collection("comments")
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }
}
