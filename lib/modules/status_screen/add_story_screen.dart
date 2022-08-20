import 'dart:io';
import 'dart:ui';

import 'package:chat_app/modules/status_screen/status_screen.dart';

import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddStoryScreen extends StatelessWidget {
  // AddStoryScreen({Key? key}) : super(key: key);
  File storyImage;
  AddStoryScreen({required this.storyImage});
  TextEditingController captionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppStates>(
      listener: (context, state) {
        // if (state is ChatAppCreateStoryLoadingState) {
        //   const Center(
        //       child: CircularProgressIndicator(
        //     backgroundColor: Colors.amber,
        //   ));
        // }
        if (state is ChatAppCreateStorySuccessState) {
          Navigator.pop(context);
          ChatAppCubit.get(context).caption = "";
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: deffaultColor,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  ChatAppCubit.get(context).caption = "";
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                )),
            actions: [
              IconButton(
                onPressed: () {
                  ChatAppCubit.get(context).uploadStoryImage(
                    dateTime: DateFormat.yMd().add_jm().format(DateTime.now()),
                    storyCaption: captionController.text,
                  );
                },
                icon: const Icon(
                  Icons.upload,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              //const SizedBox(height: 15),
              if (state is ChatAppUploadStoryImageLoadingState)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: LinearProgressIndicator(),
                ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  //height: 335,
                  width: double.infinity,
                  child: Image(image: FileImage(storyImage)

                      // NetworkImage(
                      //     "https://firebasestorage.googleapis.com/v0/b/socialapp-d6fd2.appspot.com/o/posts%2Fimage_picker-1475771096.png?alt=media&token=01b00423-67ee-4eb7-9434-7d25c264f1f3"),
                      // fit: BoxFit.cover,
                      ),
                ),
              ),
              Text(
                ChatAppCubit.get(context).caption,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: deffaultColor,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 30),
              //const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                child: deffaultFormField(
                  controller: captionController,
                  labelText: "Add Caption",
                  prefix: Icons.text_fields_sharp,
                  onChanged: (value) {
                    ChatAppCubit.get(context).changeCaption(value);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
