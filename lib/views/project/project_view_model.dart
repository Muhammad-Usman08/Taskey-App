import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProjectViewModel extends GetxController {
  var selectedIndex = 0.obs;
    final data = RxList();
  var firestore = FirebaseFirestore.instance.collection('tasks');

  void selectIndex(int index) {
    selectedIndex.value = index;
  }

  Stream<QuerySnapshot> getTask() {
    return firestore.snapshots();
  }
}
