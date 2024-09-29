import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:taskey_app/Model/firesstore_model.dart';
import 'package:taskey_app/Model/firestore_controller.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/AddTask/add_task_view.dart';
import 'package:taskey_app/views/Home/home_view.dart';
import 'package:taskey_app/views/chat/chat_screen_view.dart';
import 'package:taskey_app/views/profile/profile_view.dart';
import 'package:taskey_app/views/project/project_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainScreen> {
  // screens

  // variables
  int currentIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final FirestoreController firestoreController =
        Get.put(FirestoreController());
    List<Widget> screens = [
      HomeView(),
      ProjectView(),
      AddTaskView(),
      ChatScreen(backbutton: false),
      Profile(),
    ];

    return Scaffold(
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onItemTapped(2);
        },
        shape: CircleBorder(),
        child: SvgPicture.asset('assets/svg/Add.svg'),
        backgroundColor: Color(themeColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                onItemTapped(0); // Home
              },
              icon: SvgPicture.asset(
                'assets/svg/Home.svg',
                color: currentIndex == 0 ? Color(themeColor) : Colors.grey[500],
              ),
            ),
            IconButton(
              onPressed: () {
                onItemTapped(1); // Projects
              },
              icon: SvgPicture.asset(
                'assets/svg/Folder.svg',
                color: currentIndex == 1 ? Color(themeColor) : Colors.grey[500],
              ),
            ),
            SizedBox.shrink(), //place holder for spacing
            IconButton(
              onPressed: () {
                onItemTapped(3);
              },
              icon: SvgPicture.asset(
                'assets/svg/Chat.svg',
                color: currentIndex == 3 ? Color(themeColor) : Colors.grey[500],
              ),
            ),
            IconButton(
              onPressed: () {
                onItemTapped(4); // Profile
              },
              icon: SvgPicture.asset(
                'assets/svg/Profile.svg',
                color: currentIndex == 4 ? Color(themeColor) : Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
