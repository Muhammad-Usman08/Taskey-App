import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_view_model.dart'; // Import your ProfileViewModel
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/language/language_view.dart';
import 'package:taskey_app/views/settings/setting_view.dart';
import 'package:taskey_app/views/task/task_view.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final ProfileViewModel controller = Get.put(ProfileViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Profile',
          weight: FontWeight.w500,
          fontSize: 22,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          final user = controller.userData; // Access the user data map
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage(user['imageUrl'] ?? ''), // Use user map
                ),
                const SizedBox(height: 10),
                Text(
                  user['username'] ?? 'Unknown User', // Use user map
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  user['email'] ?? 'No Email', // Use user map
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _settingsOptions.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: Icon(
                            _getIconForOption(index),
                            color: const Color(themeColor),
                          ),
                          title: Text(
                            _settingsOptions[index],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 15),
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => Language());
                                break;
                              case 1:
                                Get.to(() => Setting());
                                break;
                              case 2:
                                Get.to(() => TaskScreen());
                                break;
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  final List<String> _settingsOptions = [
    'Language',
    'Settings',
    'Task Status',
  ];

  IconData _getIconForOption(int index) {
    switch (index) {
      case 0:
        return Icons.language;
      case 1:
        return Icons.settings;
      default:
        return Icons.help; // Default icon
    }
  }
}
