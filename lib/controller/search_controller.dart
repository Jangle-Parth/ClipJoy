import 'package:clipjoy/constants.dart';
import 'package:clipjoy/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearrchController extends GetxController {
  final Rx<List<MyUser>> _searchedUsers = Rx<List<MyUser>>([]);

  List<MyUser> get searchedUsers => _searchedUsers.value;
  searchUser(String typesUser) async {
    _searchedUsers.bindStream(firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: typesUser)
        .snapshots()
        .map((QuerySnapshot query) {
      List<MyUser> retVal = [];
      for (var elem in query.docs) {
        retVal.add(MyUser.fromSnap(elem));
      }
      return retVal;
    }));
  }
}
