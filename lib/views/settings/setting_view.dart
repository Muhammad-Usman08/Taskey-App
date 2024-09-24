import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isPermissionEnabled = false;
  bool isDarkModeEnabled = false;
  bool isPushNotificationEnabled = false;

  Widget buildOption(String title, bool isEnabled, Function onTap) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
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
                color: isEnabled ? Colors.blue : Colors.grey[300],
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
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListOption(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Updated to space between
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(width: 16),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey), // Arrow icon
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildOption('Permission', isPermissionEnabled, () {
              setState(() {
                isPermissionEnabled = !isPermissionEnabled;
              });
            }),
            const SizedBox(height: 20),
            buildOption('Dark Mode', isDarkModeEnabled, () {
              setState(() {
                isDarkModeEnabled = !isDarkModeEnabled;
              });
            }),
            const SizedBox(height: 20),
            buildOption('Push Notification', isPushNotificationEnabled, () {
              setState(() {
                isPushNotificationEnabled = !isPushNotificationEnabled;
              });
            }),
            const SizedBox(height: 30),
            buildListOption('Security', Icons.security),
            const SizedBox(height: 20),
            buildListOption('Help', Icons.help_outline),
            const SizedBox(height: 20),
            buildListOption('Language', Icons.language),
            const SizedBox(height: 20),
            buildListOption('About Application', Icons.info_outline),
          ],
        ),
      ),
    );
  }
}
