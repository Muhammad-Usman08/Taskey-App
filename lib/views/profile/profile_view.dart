import 'package:flutter/material.dart';
import 'package:taskey_app/views/chat/chat_screen_view.dart';
import 'package:taskey_app/views/edit_profile/edit_view.dart';
import 'package:taskey_app/views/language/language_view.dart';
import 'package:taskey_app/views/settings/setting_view.dart';
import 'package:taskey_app/views/task/task_view.dart'; // Import your edit.dart file

class Profile extends StatelessWidget {
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://cdn.pixabay.com/photo/2015/01/12/10/44/woman-597173_640.jpg',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Jenny Alxinder',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'JennyAlxinder22@gmail.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Add()), // Navigate to Edit screen
                );
              },
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProjectContainer(
                  'Ongoing Projects',
                  '5',
                  Colors.blue,
                  Icons.access_time,
                ),
                _buildProjectContainer(
                  'Completed Projects',
                  '10',
                  Colors.green,
                  Icons.check,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _settingsOptions.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    elevation: 4, // Adds shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(
                        _getIconForOption(index),
                        color: Colors.blue, // Customize icon color
                      ),
                      title: Text(
                        _settingsOptions[index],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      onTap: () {
                        switch (index) {
                          case 0: // Edit
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Add()),
                            );
                            break;
                          case 1: // Language
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Language()),
                            );
                            break;
                          case 2: // Settings
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Setting()),
                            );
                            break;
                          case 3: // Chat Screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatScreen()),
                            );
                            break;
                          case 4: // Task Status
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TaskScreen()),
                            );
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

  Widget _buildProjectContainer(
      String title, String count, Color color, IconData icon) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
            alignment: Alignment.center,
          ),
          const SizedBox(height: 5),
          Text(
            count,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
