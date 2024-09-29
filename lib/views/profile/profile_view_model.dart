import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileViewModel extends GetxController {
  var isLoading = true.obs;
  var userData = <String, dynamic>{}.obs; // Observable for user data

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }

  Future<void> fetchUserData() async {
    try {
      final currentUserAuth = _auth.currentUser;
      if (currentUserAuth == null) {
        throw Exception('User not logged in');
      }

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(currentUserAuth.uid).get();
      userData.value =
          userDoc.data() as Map<String, dynamic>; // Store data as a Map
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}
