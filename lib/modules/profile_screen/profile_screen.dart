import 'dart:ui';

import 'package:buildcondition/buildcondition.dart';
import 'package:chat_app/modules/edit_profile/edit_profile.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: deffaultDecoration(
                    backgroundColor: deffaultGreyColor,
                    topEnd: 20,
                    topStart: 20,
                    bottomEnd: 20,
                    bottomStart: 20,
                  ),
                  child: Row(
                    children: [
                      if (ChatAppCubit.get(context).userModel?.image != null)
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "${ChatAppCubit.get(context).userModel?.image}"),
                          radius: 30,
                        ),
                      if (ChatAppCubit.get(context).userModel?.image == null)
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740"),
                          radius: 30,
                        ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ChatAppCubit.get(context).userModel!.name ??
                                  "Gest",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          navigateTo(context, EditProfileScreen());
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: deffaultDecoration(
                    backgroundColor: deffaultGreyColor,
                    topEnd: 20,
                    topStart: 20,
                    bottomEnd: 20,
                    bottomStart: 20,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "About",
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(height: 8),
                            if (ChatAppCubit.get(context).userModel!.bio !=
                                null)
                              Text(
                                "${ChatAppCubit.get(context).userModel!.bio}",
                                style: const TextStyle(fontSize: 18),
                              ),
                            if (ChatAppCubit.get(context).userModel!.bio ==
                                null)
                              const Text(
                                "About Me...",
                                style: TextStyle(fontSize: 18),
                              ),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            navigateTo(context, EditProfileScreen());
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: deffaultDecoration(
                    backgroundColor: deffaultGreyColor,
                    topEnd: 20,
                    topStart: 20,
                    bottomEnd: 20,
                    bottomStart: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.only(start: 15, top: 15),
                        child: Text(
                          "Friends",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        height: 250,
                        padding: const EdgeInsets.all(15),
                        child: ListView.separated(
                          itemBuilder: (context, index) => friendsBuilder(),
                          separatorBuilder: (context, index) =>
                              deffaultSeparatorBuilder(),
                          itemCount: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: deffaultDecoration(
                    backgroundColor: deffaultGreyColor,
                    topEnd: 20,
                    topStart: 20,
                    bottomEnd: 20,
                    bottomStart: 20,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Log Out",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            ChatAppCubit.get(context).signOut(context);
                          },
                          icon: const Icon(
                            Icons.exit_to_app,
                            color: Colors.blue,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget friendsBuilder() => Column(
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://firebasestorage.googleapis.com/v0/b/courseflutter-2d8c3.appspot.com/o/Images%2Faba.jpg?alt=media&token=7c72fc9b-db46-4c61-9c06-101c12910abe"),
              radius: 25,
            ),
            const SizedBox(width: 10),
            const Text("Abanoub Ezzat"),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.blue,
              ),
            )
          ],
        ),
      ],
    );
