import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/chat/chat_view_model.dart';

class ChattingView extends StatelessWidget {
  final String chatRoomId;
  final Map? userMap;
  ChattingView({super.key, required this.chatRoomId, required this.userMap});

  final controller = Get.put(ChatViewModel());

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
                      return Align(
                        alignment: map['sendBy'] ==
                                controller.auth.currentUser?.displayName
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, right: 13, left: 13),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 5),
                          decoration: BoxDecoration(
                            color: map['sendBy'] ==
                                    controller.auth.currentUser?.displayName
                                ? const Color(themeColor)
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            map['message'],
                            style: const TextStyle(color: Colors.white),
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
                      fillColor: Color.fromARGB(255, 35, 45, 52),
                      hintText: 'Enter message',
                      hintStyle: TextStyle(color: Colors.white54),
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
                    controller.onSendMessage(chatRoomId);
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
