import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingViewModel extends GetxController {
  var isPermissionEnabled = false.obs;
  var isDarkModeEnabled = false.obs;
  var isPushNotificationEnabled = false.obs;

  void togglePermission() {
    isPermissionEnabled.value = !isPermissionEnabled.value;
  }

  void toggleDarkMode() {
    isDarkModeEnabled.value = !isDarkModeEnabled.value;
  }

  void togglePushNotification() {
    isPushNotificationEnabled.value = !isPushNotificationEnabled.value;
  }

  ThemeData get themeData {
    return isDarkModeEnabled.value ? ThemeData.dark() : ThemeData.light();
  }
}
