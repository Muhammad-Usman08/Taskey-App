import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get/get.dart';
import 'package:taskey_app/Model/firesstore_model.dart';

class FirestoreController extends GetxController {
  var users = <User>[].obs;
  User? currentUser;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  Future<void> fetchUsers() async {
    try {
      // Get the currently authenticated user
      final currentUserAuth = auth.FirebaseAuth.instance.currentUser;

      if (currentUserAuth == null) {
        print("No authenticated user found");
        return;
      }

      var usersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      users.value = usersSnapshot.docs.map((doc) {
        return User.fromDocument(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();

      // Identify the currently authenticated user from the fetched list
      currentUser =
          users.firstWhereOrNull((user) => user.userId == currentUserAuth.uid);

      if (currentUser != null) {
        print("Current User: ${currentUser!.username}");
      } else {
        print("Authenticated user not found in Firestore users collection");
      }
    } catch (e) {
      print('Error fetching users: $e');
    }
  }
}
