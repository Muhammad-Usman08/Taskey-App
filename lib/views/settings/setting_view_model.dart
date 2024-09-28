import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingViewModel extends GetxController {
  var isPermissionEnabled = false.obs;
  var isDarkModeEnabled = false.obs;
  var isPushNotificationEnabled = false.obs;

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
}
