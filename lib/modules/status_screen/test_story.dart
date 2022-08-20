import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/models/story_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/modules/status_screen/status_screen.dart';
import 'package:chat_app/modules/status_screen/story_views.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/components/constatnts.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:story_page_view/story_page_view.dart';
import 'package:story_view/story_view.dart';

class TestStory extends StatelessWidget {
  final StoryController controllerr = StoryController();
  PageController pageController = PageController();
  StoryPageController storyPageController = StoryPageController();
  TextEditingController replayController = TextEditingController();
  UserModel? user;
  List<StoryModel>? myStoryList;
  TestStory({Key? key, this.user, this.myStoryList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 70,
            backgroundColor: Colors.black,
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage("${user!.image}"),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${user!.name}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: SizedBox(
            height: double.infinity,
            child: PageView.builder(
              controller: pageController,
              itemBuilder: (context, index) => storyTestBuilder(
                myStoryList![index],
                // ChatAppCubit.get(context).story[index],
                controllerr,
                pageController,
                index,
                myStoryList!,
                replayController,
                context,
              ),
              itemCount: myStoryList!.length,
              //ChatAppCubit.get(context).story.length,
            ),
          ),
        );
      },
    );
  }
}

Widget storyTestBuilder(
  StoryModel storyModel,
  StoryController controller,
  pagecontroller,
  index,
  List<StoryModel> myStoryList,
  TextEditingController messageController,
  context,
) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10, bottom: 15),
          width: double.infinity,
          color: Colors.black,
          child: Row(
            children: [
              Text(
                storyModel.dateTime!,
                style: const TextStyle(color: Colors.white),
              ),
              const Spacer(),
              if (storyModel.uId == uId)
                IconButton(
                  onPressed: () {
                    controller.pause();
                    //navigateTo(context, StoryViews());
                    ChatAppCubit.get(context).getstoryViews(
                      context: context,
                      storyDocId: storyModel.storyId,
                      storyPublisherId: storyModel.uId,
                      storyModel: storyModel,
                    );
                    //showModel(context);
                  },
                  icon: const Icon(
                    Icons.remove_red_eye,
                    color: Colors.white,
                  ),
                ),
              const SizedBox(width: 10),
              if (storyModel.uId == uId)
                IconButton(
                  onPressed: () {
                    ChatAppCubit.get(context).deleatStory(storyModel.storyId);
                    // ChatAppCubit.get(context).deleatStoryCollection(
                    //     storyModel.uId, storyModel.storyId);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: StoryView(
            controller: controller,
            storyItems: [
              if (storyModel.storyImage == "")
                StoryItem.text(
                  title: storyModel.caption!,
                  backgroundColor: Colors.blue,
                  roundedTop: true,
                ),
              if (storyModel.storyImage != "")
                StoryItem.inlineImage(
                  url: storyModel.storyImage!,
                  controller: controller,
                  caption: Text(
                    storyModel.caption!,
                    style: const TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.black54,
                      fontSize: 17,
                    ),
                  ),
                )
            ],
            onStoryShow: (s) {
              ChatAppCubit.get(context).addStoryViews(
                storyPublisher: storyModel.uId,
                storyId: storyModel.storyId,
                storyImage: storyModel.storyImage,
                caption: storyModel.caption,
                dateTime: DateFormat.yMd().add_jm().format(DateTime.now()),
              );
              print("Showing a story");
            },
            onComplete: () {
              if (myStoryList.length - 1 == index) {
                Navigator.pop(context);
              } else {
                _scrollToIndex(pagecontroller, index);
              }

              print("Completed a cycle");
            },
            onVerticalSwipeComplete: (direction) {
              if (direction == Direction.down) {
                Navigator.pop(context);
              }
              // if (direction == Direction.up) {
              //   controller.playbackNotifier.onPause;
              //   showModel(context);
              // }
            },
            progressPosition: ProgressPosition.top,
            repeat: false,
            inline: true,
          ),
        ),
        const SizedBox(height: 2),
        Container(
          color: Colors.white,
          height: 2,
        ),
        if (storyModel.uId != uId)
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            height: 50,
            width: double.infinity,
            color: Colors.black,
            child: IconButton(
                onPressed: () {
                  controller.pause();
                  showReplayModel(context, messageController, storyModel);
                },
                icon: const Icon(
                  Icons.keyboard_arrow_up_sharp,
                  size: 45,
                  color: Colors.white,
                )),
          ),
        if (storyModel.uId == uId)
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            height: 20,
            width: double.infinity,
            color: Colors.black,
          )
      ],
    );
void _scrollToIndex(PageController pagecontroller, int index) {
  pagecontroller.animateToPage(index + 1,
      duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
}

void showReplayModel(context, messageController, StoryModel storyModel) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.only(
        topStart: Radius.circular(20),
        topEnd: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (context) {
      return SizedBox(
        height: 70,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
                                reciverId: storyModel.uId!,
                                dateTime: DateTime.now().toString(),
                                text:
                                    "Replied to your story with.. ${messageController.text}",
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
                    )),
              ],
            ),
          ),
        ),
      );
    },
  );
}

// Widget storyViews() => Row(
//       children: const [
//         CircleAvatar(
//           backgroundImage: NetworkImage(
//               "https://firebasestorage.googleapis.com/v0/b/courseflutter-2d8c3.appspot.com/o/Images%2Faba.jpg?alt=media&token=7c72fc9b-db46-4c61-9c06-101c12910abe"),
//           radius: 18,
//         ),
//         SizedBox(width: 10),
//         Text("Abanoub Ezaat"),
//         Spacer(),
//         Text("02:32 PM"),
//       ],
//     );



/**
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
                        reciverId: storyModel.uId!,
                        dateTime: DateTime.now().toString(),
                        text: messageController.text,
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
            )
 */






// void showModel(context) {
//   showModalBottomSheet(
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadiusDirectional.only(
//         topStart: Radius.circular(20),
//         topEnd: Radius.circular(20),
//       ),
//     ),
//     context: context,
//     builder: (context) {
//       return SizedBox(
//         height: 270,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ListView.separated(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemBuilder: (context, index) => storyViews(),
//                   separatorBuilder: (context, index) => Container(
//                     margin:
//                         const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                     height: 1,
//                     width: double.infinity,
//                     color: Colors.grey,
//                   ),
//                   itemCount: 8,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Center(
//                     heightFactor: 3,
//                     child: Text(
//                       'Cancel',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                         color: deffaultColor,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }