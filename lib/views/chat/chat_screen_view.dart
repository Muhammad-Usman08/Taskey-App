import 'package:flutter/material.dart';
import 'package:taskey_app/components/custom_texfield.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/chat/widget/avatar_widget.dart';

class ChatScreen extends StatelessWidget {
  final bool backbutton;
  const ChatScreen({super.key, required this.backbutton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const CustomText(
          text: 'Chat',
          weight: FontWeight.w500,
          fontSize: 20,
        ),
        automaticallyImplyLeading: backbutton,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: Column(
          children: [
            CustomTextField(
              hintText: 'Search',
            ),
            SizedBox(height: 30),
            UserChatWidget(
                imageUrl:
                    'https://cdn.pixabay.com/photo/2015/01/12/10/44/woman-597173_640.jpg',
                name: 'Jenny'),
            UserChatWidget(
                imageUrl:
                    'https://cdn.pixabay.com/photo/2015/01/12/10/44/woman-597173_640.jpg',
                name: 'Jenny'),
            UserChatWidget(
                imageUrl:
                    'https://cdn.pixabay.com/photo/2015/01/12/10/44/woman-597173_640.jpg',
                name: 'Jenny'),
            UserChatWidget(
                imageUrl:
                    'https://cdn.pixabay.com/photo/2015/01/12/10/44/woman-597173_640.jpg',
                name: 'Jenny'),
          ],
        ),
      ),
    );
  }
}
