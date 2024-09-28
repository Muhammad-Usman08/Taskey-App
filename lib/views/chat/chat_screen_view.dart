import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:taskey_app/Model/firestore_controller.dart';
import 'package:taskey_app/components/common_button.dart';
import 'package:taskey_app/components/custom_texfield.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/chat/chat_view_model.dart';
import 'package:taskey_app/views/chat/chatting_view.dart';

class ChatScreen extends StatelessWidget {
  final bool backbutton;
  ChatScreen({super.key, required this.backbutton});

  final controller = Get.put(ChatViewModel());
  final firestoreController = Get.find<FirestoreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Chat',
          weight: FontWeight.w500,
          fontSize: 22,
        ),
        automaticallyImplyLeading: backbutton,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(screenPadding),
            child: Column(
              children: [
                CustomTextField(
                  hintText: 'Search',
                  controller: controller.searchController,
                ),
                SizedBox(height: 30),
                CommonButton(
                  title: 'Search',
                  horizontalPadding: 40,
                  onPressed: () {
                    controller.onSearch();
                  },
                ),
                controller.userMap != null
                    ? Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: ListTile(
                          onTap: () {
                            String currentUser =
                                firestoreController.currentUser?.username ??
                                    'currentUser';
                            String otherUser =
                                controller.userMap?['username'] ?? 'toChat';

                            String roomId =
                                controller.chatRoomId(currentUser, otherUser);

                            if (roomId.isNotEmpty) {
                              Get.to(ChattingView(
                                  chatRoomId: roomId,
                                  userMap: controller.userMap));
                            }
                          },
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage(controller.userMap!['imageUrl']),
                          ),
                          title: CustomText(
                            text: controller.userMap!['username'],
                            weight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          subtitle: CustomText(
                            text: controller.userMap!['email'],
                            fontSize: 12,
                          ),
                          trailing: SvgPicture.asset('assets/svg/Chat.svg'),
                        ),
                      )
                    : Container(),
              ],
            ),
          );
        }
      }),
    );
  }
}
