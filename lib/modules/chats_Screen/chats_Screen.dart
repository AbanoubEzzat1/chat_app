import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/modules/chats_Screen/detailschatscreen.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/components/constatnts.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                    padding:
                        const EdgeInsetsDirectional.only(top: 10, bottom: 25),
                    child: deffaultFormField(
                      controller: searchController,
                      labelText: 'Search',
                      prefix: Icons.search,
                    )),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => chatBuilder(
                      ChatAppCubit.get(context).allUsersChat[index], context),
                  separatorBuilder: (context, index) =>
                      deffaultSeparatorBuilder(),
                  itemCount: ChatAppCubit.get(context).allUsersChat.length,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget chatBuilder(UserModel userModel, context) => Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                print("Open Story");
              },
              child: CircleAvatar(
                backgroundColor: Colors.blue.shade300,
                radius: 29,
                child: CircleAvatar(
                  backgroundImage: userModel.image != null
                      ? NetworkImage("${userModel.image}")
                      : const NetworkImage(
                          "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740"),
                  radius: 25,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InkWell(
                onTap: () {
                  navigateTo(
                      context,
                      DetailsChatScreen(
                        userModel: userModel,
                      ));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("${userModel.name}"),
                        const Spacer(),
                        Text(
                          "10h ago",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    // if (userModel.uId == uId)
                    const Text("Last Message"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );



/**
 Future<void> sendNotification(subject, title) async {
    final postUrl = 'https://fcm.googleapis.com/fcm/send';

    final data = {
      "notification": {"body": subject, "title": title},
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        'chatID': widget.chatId,
        "sound": 'default',
      },
      "to": '$token'
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=$keyMessaging'
    };

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      print("MessageIsSend");
    } else {
      print("false");
    }
  }
 */