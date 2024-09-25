import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskey_app/utils/constants.dart';
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
  List screens = [
    HomeView(),
    ProjectView(),
    ChatScreen(
      backbutton: false,
    ),
    Profile(),
  ];

  //variables
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(themeColor),
          unselectedItemColor: Colors.grey[500],
          backgroundColor: Colors.white,
          // type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (value) {
            selectedIndex = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/svg/Home.svg'), label: 'Home'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/svg/Folder.svg'),
                label: 'Projects'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/svg/Chat.svg'), label: 'Chat'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/svg/Profile.svg'),
                label: 'Profile')
          ]),
    );
  }
}
