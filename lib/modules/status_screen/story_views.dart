import 'package:chat_app/models/story_model.dart';
import 'package:chat_app/models/story_viewre_model.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoryViews extends StatelessWidget {
  StoryViews({
    Key? key,
    required this.myStoryViewsList,
    this.storyModel,
  }) : super(key: key);
  List<StoryViewerModel> myStoryViewsList;
  StoryModel? storyModel;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: deffaultColor,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                if (storyModel!.storyImage != "")
                  Expanded(
                    flex: 2,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage("${storyModel!.storyImage}"),
                          ),
                        ),
                        if (storyModel!.storyImage != "" &&
                            storyModel!.caption != "")
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            margin: const EdgeInsets.only(bottom: 8),
                            color: Colors.white.withOpacity(0.4),
                            child: Text(
                              "${storyModel!.caption}",
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                if (storyModel!.storyImage == "")
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 200,
                      color: Colors.blue,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "${storyModel!.caption}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    //height: 350,
                    child: ListView.separated(
                      //physics: const NeverScrollableScrollPhysics(),
                      // shrinkWrap: true,
                      itemBuilder: (context, index) => storyViews(
                        myStoryViewsList[index],
                      ),
                      separatorBuilder: (context, index) => Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                      ),
                      itemCount: myStoryViewsList.length,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Icon(Icons.remove_red_eye),
                    const SizedBox(width: 10),
                    Text(
                      "${myStoryViewsList.length}",
                      style: const TextStyle(
                        fontSize: 18,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Views",
                      style: TextStyle(
                        fontSize: 18,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget storyViews(StoryViewerModel storyViewerModel) => Container(
      color: Colors.grey.shade300,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage("${storyViewerModel.image}"),
            radius: 18,
          ),
          const SizedBox(width: 10),
          Text("${storyViewerModel.name}"),
          const Spacer(),
          Text("${storyViewerModel.dateTime}"),
        ],
      ),
    );
