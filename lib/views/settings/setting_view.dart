import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskey_app/components/common_button.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/settings/setting_view_model.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingViewModel settingsController =
        Get.find(); // Get the Settings Controller

    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Setting',
          weight: FontWeight.w500,
          fontSize: 20,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Obx(() => buildOption(
                    'Dark Mode', settingsController.isDarkModeEnabled.value,
                    () {
                  settingsController.toggleDarkMode();
                })),
            const SizedBox(height: 30),
            buildListOption('Security', Icons.security),
            const SizedBox(height: 20),
            buildListOption('Help', Icons.help_outline),
            const SizedBox(height: 20),
            buildListOption('Language', Icons.language),
            const SizedBox(height: 20),
            buildListOption('About Application', Icons.info_outline),
            const SizedBox(height: 20),
            CommonButton(
              onPressed: () {
                settingsController.logOut();
              },
              title: 'Log Out',
              isLoading: settingsController.isLoading.value,
              vertcalPaddingM: 15,
            )
          ],
        ),
      ),
    );
  }

  Widget buildOption(String title, bool isEnabled, Function onTap) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            GestureDetector(
              onTap: () => onTap(),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isEnabled ? Color(themeColor) : Colors.grey[400],
                ),
                child: AnimatedAlign(
                  alignment:
                      isEnabled ? Alignment.centerRight : Alignment.centerLeft,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white54,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListOption(String title, IconData icon) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Color(themeColor)),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
