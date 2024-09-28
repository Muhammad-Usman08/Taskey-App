import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    as auth; // Alias Firebase Auth's User class
import 'package:get/get.dart';
import 'package:taskey_app/Model/firesstore_model.dart'; // Import your custom User model

class ProfileViewModel extends GetxController {
  var isLoading = true.obs;
  User? currentUser; // This refers to your custom User model

  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }

  Future<void> fetchUserData() async {
    try {
      isLoading(true);

      // Get the current authenticated user from Firebase Auth
      final auth.User? user = auth.FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('No user logged in');
        isLoading(false);
        return;
      }

      // Fetch user data from Firestore
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        currentUser = User.fromDocument(user.uid, userDoc.data()!);
      }

      isLoading(false);
    } catch (e) {
      print('Error fetching user data: $e');
      isLoading(false);
    }
  }
}
