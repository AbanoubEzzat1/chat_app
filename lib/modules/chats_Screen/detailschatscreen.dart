import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/modules/chats_Screen/chats_Screen.dart';
import 'package:chat_app/shared/components/constatnts.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsChatScreen extends StatelessWidget {
  UserModel? userModel;
  DetailsChatScreen({this.userModel});
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        ChatAppCubit.get(context).getMessages(reciverId: userModel!.uId!);
        return BlocConsumer<ChatAppCubit, ChatAppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                elevation: 0,
                backgroundColor: deffaultColor,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage("${userModel!.image}")
                        // NetworkImage(
                        //     "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740"),
                        ),
                    SizedBox(width: 10),
                    Text(
                      "${userModel!.name}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          var message =
                              ChatAppCubit.get(context).message[index];
                          if (ChatAppCubit.get(context).userModel!.uId ==
                              message.senderId)
                            return buildFriendMessage(message);
                          return buildMyMessage(message);
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: ChatAppCubit.get(context).message.length,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[400]!,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.emoji_emotions_outlined),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Message...",
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: deffaultColor,
                              borderRadius: const BorderRadiusDirectional.only(
                                topEnd: Radius.circular(15),
                                bottomEnd: Radius.circular(15),
                              ),
                            ),
                            height: 48,
                            child: IconButton(
                              onPressed: () {
                                ChatAppCubit.get(context).sendMessage(
                                  reciverId: userModel!.uId!,
                                  dateTime: DateTime.now().toString(),
                                  text: messageController.text,
                                );
                                ChatAppCubit.get(context).sendNotification(
                                  messageController.text,
                                  myName,
                                  userModel!.myToken,
                                  context,
                                );
                                messageController.clear();
                              },
                              icon: const Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMyMessage(MessagerModel messagerModel) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
              )),
          child: Text("${messagerModel.text}"),
        ),
      );
  Widget buildFriendMessage(MessagerModel messagerModel) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            ),
          ),
          child: Text("${messagerModel.text}"),
        ),
      );
}
