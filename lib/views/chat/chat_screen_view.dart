import 'package:flutter/material.dart';
import 'package:taskey_app/views/chat/widget/avatar_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => () {}, // Open camera on tap
                    child: const AvatarWidget(
                      imageUrl:
                          'https://cdn.pixabay.com/photo/2015/01/12/10/44/woman-597173_640.jpg',
                      name: 'Jenny',
                    ),
                  ),
                  Divider(), // Divider after first avatar
                  GestureDetector(
                    onTap: () => () {},
                    child: const AvatarWidget(
                      imageUrl:
                          'https://cdn.pixabay.com/photo/2016/03/27/17/40/man-1283231_640.jpg',
                      name: 'Team Align',
                    ),
                  ),
                  Divider(), // Divider after second avatar
                  GestureDetector(
                    onTap: () => () {},
                    child: const AvatarWidget(
                      imageUrl:
                          'https://cdn.pixabay.com/photo/2017/08/01/01/33/beanie-2562646_640.jpg',
                      name: 'Jafor Dicrose',
                    ),
                  ),
                  Divider(), // Divider after third avatar
                  GestureDetector(
                    onTap: () => () {},
                    child: const AvatarWidget(
                      imageUrl:
                          'https://cdn.pixabay.com/photo/2022/09/02/20/03/man-7428290_640.jpg',
                      name: 'Alex Avishake',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
