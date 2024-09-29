import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskey_app/views/main/main_screen.dart';

class LoginViewModel extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var loading = false.obs;

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Email and password must not be empty');
      return;
    }

    loading.value = true;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      //user data fetch from Firestore
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();

      // Handle successful login
      Get.snackbar('Success', 'Logged in successfully');
      // Navigate to main screen or home
      Get.offAll(() => MainScreen());
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided for that user.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        default:
          message = 'An error occurred. Please try again.';
      }
      Get.snackbar('Error', message);
    } catch (e) {
      Get.snackbar('Error', 'An error occurred. Please try again.');
    } finally {
      loading.value = false; // Stop loading regardless of the outcome
    }
  }
}
