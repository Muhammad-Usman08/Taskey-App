import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/chat/chat_view_model.dart';
import 'package:taskey_app/views/profile/profile_view_model.dart';

class ChattingView extends StatelessWidget {
  final String chatRoomId;
  final Map? userMap;
  ChattingView({super.key, required this.chatRoomId, required this.userMap});

  final controller = Get.put(ChatViewModel());
  final firestoreController = Get.put(ProfileViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          userMap?['username'] ?? 'Chat',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: controller.firestore
                  .collection('chatroom')
                  .doc(chatRoomId)
                  .collection('chats')
                  .orderBy('time', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> map =
                          snapshot.data!.docs[index].data();

                      // Check if the message is sent by the current user
                      bool isCurrentUser = map['sendBy'] ==
                          firestoreController.userData['username'];

                      return Align(
                        alignment: isCurrentUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 13),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 5),
                          decoration: BoxDecoration(
                            color: isCurrentUser
                                ? const Color(
                                    themeColor) // Current user message color
                                : Colors.grey
                                    .shade300, // Other user's message color
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(12),
                              topRight: const Radius.circular(12),
                              bottomLeft: isCurrentUser
                                  ? const Radius.circular(12)
                                  : Radius.zero,
                              bottomRight: isCurrentUser
                                  ? Radius.zero
                                  : const Radius.circular(12),
                            ),
                          ),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width *
                                0.7, // Control the width of the chat bubble
                          ),
                          child: Text(
                            map['message'],
                            style: TextStyle(
                              color: isCurrentUser
                                  ? Colors
                                      .white // Text color for current user's message
                                  : Colors
                                      .black, // Text color for other user's message
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.message,
                    cursorColor: const Color(themeColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 35, 45, 52),
                      hintText: 'Enter message',
                      hintStyle: const TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 35, 45, 52),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 35, 45, 52),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 35, 45, 52),
                        ),
                      ),
                      focusColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Color(themeColor),
                  ),
                  onPressed: () {
                    final username = firestoreController.userData['username'];
                    if (username != null && username.isNotEmpty) {
                      controller.onSendMessage(chatRoomId, username);
                    } else {
                      // Handle error: user not authenticated or username not available
                      print('Error: Username not found');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
