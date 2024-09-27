import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskey_app/Model/firesstore_model.dart';
import 'package:taskey_app/components/common_button.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/chat/chat_screen_view.dart';
import 'package:taskey_app/views/edit_profile/edit_view.dart';
import 'package:taskey_app/views/language/language_view.dart';
import 'package:taskey_app/views/settings/setting_view.dart';
import 'package:taskey_app/views/task/task_view.dart'; // Import your edit.dart file

class Profile extends StatelessWidget {
  Profile({
    super.key,
    required this.user,
  });
  final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CustomText(
          text: 'Profile',
          weight: FontWeight.w500,
          fontSize: 20,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                '${user.imageUrl}',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${user.username}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              '${user.email}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            CommonButton(
              title: 'Edit',
              horizontalPadding: 25,
              onPressed: () {
                Get.to(() => Add());
              },
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
                    color: Colors.white,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    elevation: 4, // Adds shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(
                        _getIconForOption(index),
                        color: const Color(themeColor), // Customize icon color
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
                          case 0: // Edit
                            Get.to(() => Add());
                            break;
                          case 1: // Language
                            Get.to(() => Language());
                            break;
                          case 2: // Settings
                            Get.to(() => Setting());
                            break;
                          case 3: // Chat Screen
                            Get.to(() => ChatScreen(
                                  backbutton: true,
                                ));
                            break;
                          case 4: // Task Status
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
      ),
    );
  }

  final List<String> _settingsOptions = [
    'Edit',
    'Language',
    'Settings',
    'Chat Screen',
    'Task Status',
  ];

  IconData _getIconForOption(int index) {
    switch (index) {
      case 0:
        return Icons.edit;
      case 1:
        return Icons.language;
      case 2:
        return Icons.settings;
      case 3:
        return Icons.chat;
      default:
        return Icons.help; // Default icon
    }
  }
}
