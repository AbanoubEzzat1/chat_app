import 'dart:io';

import 'package:chat_app/models/story_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/modules/status_screen/add_story_screen.dart';
import 'package:chat_app/modules/status_screen/add_story_text_screen.dart';

import 'package:chat_app/modules/status_screen/test_story.dart';

import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:story_view/story_view.dart';

class StatusScreen extends StatelessWidget {
  StatusScreen({Key? key}) : super(key: key);
  StoryController storyImageController = StoryController();
  File? storyImageFlie;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppStates>(
      listener: (context, state) {
        if (state is ChatAppGetStoryImageSuccessState) {
          // navigateTo(
          //     context,
          //     AddStoryScreen(
          //       storyImage: storyImageFlie!,
          //     ));

          // if (storyImageFlie != null) {
          //   navigateTo(
          //       context,
          //       AddStoryScreen(
          //         storyImage: storyImageFlie!,
          //       ));
          // }
        }
      },
      builder: (context, state) {
        storyImageFlie = ChatAppCubit.get(context).storyImageFile;
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: HexColor('#CECECE'),
                    borderRadius:
                        const BorderRadiusDirectional.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.only(end: 10, start: 5),
                    child: Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: const [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://firebasestorage.googleapis.com/v0/b/courseflutter-2d8c3.appspot.com/o/Images%2Faba.jpg?alt=media&token=7c72fc9b-db46-4c61-9c06-101c12910abe"),
                              radius: 25,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                bottom: 3,
                                end: 3,
                              ),
                              child: CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.add,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("My Status"),
                              SizedBox(height: 3),
                              Text("Add to my status"),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          child: IconButton(
                            onPressed: () {
                              // navigateTo(context, StoryScreen());
                              ChatAppCubit.get(context).getStoryImage(context);
                            },
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          child: IconButton(
                            onPressed: () {
                              navigateTo(context, AddStoryTextScreen());
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ////////
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: HexColor('#CECECE'),
                    borderRadius:
                        const BorderRadiusDirectional.all(Radius.circular(20)),
                  ),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => statusBuilder(
                      ChatAppCubit.get(context).myUser[index],
                      index,
                      context,
                      storyImageController,
                    ),
                    separatorBuilder: (context, index) =>
                        deffaultSeparatorBuilder(),
                    itemCount: ChatAppCubit.get(context).myUser.length,
                  ),
                ),
                const SizedBox(height: 20),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => statusBuilder(
                    ChatAppCubit.get(context).allUsers[index],
                    index,
                    context,
                    storyImageController,
                  ),
                  separatorBuilder: (context, index) =>
                      deffaultSeparatorBuilder(),
                  itemCount: ChatAppCubit.get(context).allUsers.length,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget statusBuilder(
  UserModel userModel,
  index,
  context,
  storyImageController,
) =>
    Column(
      children: [
        InkWell(
          onTap: () {
            //ChatAppCubit.get(context).getStoryy(userModel: userModel);
            ChatAppCubit.get(context)
                .getUserStory(userModel: userModel, context: context);
            // navigateTo(
            //   context,
            //   TestStory(
            //     user: userModel,
            //     usrid: userModel.uId,
            //   ),
            // );
          },
          child: Row(
            children: [
              CircleAvatar(
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
              const SizedBox(width: 10),
              Text(
                "${userModel.name}",
                style: const TextStyle(fontSize: 18),
              ),
              // Spacer(),
              // IconButton(
              //     onPressed: () {
              //       //ChatAppCubit.get(context).getUsershaveStories();

              //       //ChatAppCubit.get(context).getUsershaveStories();
              //       // ChatAppCubit.get(context)
              //       //     .getStoryy(userModel: userModel, context: context);
              //     },
              //     icon: const Icon(Icons.cabin))
            ],
          ),
        ),
      ],
    );
