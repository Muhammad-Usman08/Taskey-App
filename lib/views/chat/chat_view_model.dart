import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatViewModel extends GetxController {
  //controllers
  TextEditingController message = TextEditingController();
  TextEditingController searchController = TextEditingController();
  RxBool isLoading = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Map? userMap;

  //chat Room id
  String chatRoomId(String user1, String user2) {
    if (user1.toLowerCase().compareTo(user2.toLowerCase()) > 0) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  //search function
  onSearch() async {
    isLoading(true);

    Future.delayed(const Duration(seconds: 3), () {
      if (userMap == null) {
        isLoading(false);

        Get.snackbar(
            'User Not Found', 'The user you search is not exist in this App');
      }
    });

    await firestore
        .collection('users')
        .where('username', isEqualTo: searchController.text)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        userMap = value.docs[0].data();
        isLoading(false);
      } else {
        userMap = null;
      }
    });
    searchController.clear();
  }

  onSendMessage(String chatRoomId, String sendBy) async {
    if (message.text.isNotEmpty && sendBy.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendBy": sendBy,
        "message": message.text,
        "time": FieldValue.serverTimestamp(),
      };
      message.clear();
      await firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print('Error: Message is empty or sendBy is null');
    }
  }
}
