import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskey_app/views/main/main_screen.dart';
import 'package:taskey_app/views/profile/profile_view_model.dart'; // Import ProfileViewModel

class SignupViewModel extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var imageFile = ''.obs;
  var loading = false.obs;

  Future<void> signup() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        usernameController.text.isEmpty ||
        imageFile.value.isEmpty) {
      Get.snackbar('Error', 'All fields must be filled out');
      return;
    }
    loading.value = true;

    try {
      // Create user in Firebase Auth
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Upload image to Firebase Storage
      String imageUrl = await uploadImage(userCredential.user?.uid);

      // Store user data in Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'email': emailController.text,
        'username': usernameController.text,
        'userId': userCredential.user?.uid,
        'imageUrl': imageUrl, // Store image URL
      });

      // Update ProfileViewModel with the new user's information
      Get.find<ProfileViewModel>().fetchUserData();

      Get.snackbar('Success', 'Account created successfully');
      usernameController.clear();
      emailController.clear();
      passwordController.clear();
      imageFile.value = ''; // Clear image file

      // Navigate to the main screen
      Get.offAll(() => MainScreen());
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'weak-password':
          message = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          message = 'The account already exists for that email.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        default:
          message = 'An undefined error happened.';
      }
      Get.snackbar('Error', message);
    } catch (e) {
      Get.snackbar('Error', 'An error occurred. Please try again.');
    } finally {
      loading.value = false;
    }
  }

  Future<String> uploadImage(String? userId) async {
    if (imageFile.value.isEmpty) return '';

    File file = File(imageFile.value);
    try {
      // Create a reference to the Firebase Storage
      Reference ref = _storage.ref().child('user_images/$userId');
      // Upload the image
      await ref.putFile(file);
      // Get the download URL
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      Get.snackbar('Error', 'Image upload failed');
      return '';
    }
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile.value = pickedFile.path;
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }
}
