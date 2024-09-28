import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskey_app/views/authentication/signUp/signup_view.dart';

class SettingViewModel extends GetxController {
  var isPermissionEnabled = false.obs;
  var isDarkModeEnabled = false.obs;
  var isPushNotificationEnabled = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadThemePreference();
  }

  void togglePermission() {
    isPermissionEnabled.value = !isPermissionEnabled.value;
  }

  void toggleDarkMode() {
    isDarkModeEnabled.value = !isDarkModeEnabled.value;
    _saveThemePreference(isDarkModeEnabled.value);
  }

  void togglePushNotification() {
    isPushNotificationEnabled.value = !isPushNotificationEnabled.value;
  }

  ThemeData get themeData {
    return isDarkModeEnabled.value ? ThemeData.dark() : ThemeData.light();
  }

  Future<void> _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkModeEnabled.value = prefs.getBool('dark_mode') ?? false;
  }

  // Save theme preference to SharedPreferences
  Future<void> _saveThemePreference(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', isDarkMode);
  }

  //logout functionality
  logOut() async {
    isLoading(true);
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(SignupView());
    } catch (e) {
      Get.snackbar('Error', 'Failed to logout');
    }
    isLoading(false);
  }
}
