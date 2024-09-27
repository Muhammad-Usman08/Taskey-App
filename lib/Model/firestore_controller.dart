import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:taskey_app/Model/firesstore_model.dart';

class FirestoreController extends GetxController {
  var users = <User>[].obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  Future<void> fetchUsers() async {
    try {
      var usersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      users.value = usersSnapshot.docs.map((doc) {
        return User.fromDocument(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  User? get currentUser {
    if (users.isNotEmpty) {
      return users.first;
    }
    return null;
  }
}
