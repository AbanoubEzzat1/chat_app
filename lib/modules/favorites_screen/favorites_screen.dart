import 'package:chat_app/models/story_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/modules/chats_Screen/detailschatscreen.dart';

import 'package:chat_app/modules/status_screen/test_story.dart';

import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_view/controller/story_controller.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();
  StoryController storyImageController = StoryController();
  UserModel? userId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppStates>(
      listener: (context, state) {
        // if (state is ChatAppGetStoryViewSuccessState) {
        //   navigateTo(
        //       context,
        //       TestStory(
        //         user: userId!,
        //       ));
        // }
      },
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
                          ChatAppCubit.get(context).allUsers[index],
                          index,
                          context,
                          storyImageController,
                        ),
                    separatorBuilder: (context, index) =>
                        deffaultSeparatorBuilder(),
                    itemCount: ChatAppCubit.get(context).allUsers.length),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget chatBuilder(
  UserModel userModel,
  index,
  context,
  storyImageController,
) =>
    Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                print("Open Story");
                //navigateTo(context, MyHomePage());

                //ChatAppCubit.get(context).getStoryy(userModel: userModel);
                navigateTo(context, TestStory());
                // ChatAppCubit.get(context).getUserStory(
                //   userid: userModel,
                //   //controller: storyImageController,
                // );
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
            IconButton(
                onPressed: () {
                  // ChatAppCubit.get(context).storyView(
                  //   storyImageController: storyImageController,
                  //   userId: userModel.uId!,
                  // );
                  //ChatAppCubit.get(context).getUserStory(userId: userModel.uId);
                  navigateTo(
                      context,
                      TestStory(
                        user: userModel,
                      ));
                  // navigateTo(
                  //     context,
                  //     StoriesUserView(
                  //       user: userModel,
                  //       index: index,
                  //     ));
                },
                icon: const Icon(Icons.headphones)),
          ],
        ),
      ],
    );
