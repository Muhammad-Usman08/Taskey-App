import 'package:flutter/material.dart';
import 'package:taskey_app/utils/constants.dart';

class UserChatWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final void Function()? ontap;

  const UserChatWidget({
    Key? key,
    required this.imageUrl,
    required this.name,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: ontap,
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(imageUrl),
            ),
            title: Text(name),
            trailing: Icon(
              Icons.chat,
              color: Color(themeColor),
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Divider(),
        SizedBox(
          height: 8,
        )
      ],
    );
  }
}
