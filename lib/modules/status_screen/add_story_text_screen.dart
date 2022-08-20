import 'dart:io';
import 'dart:ui';

import 'package:chat_app/modules/status_screen/status_screen.dart';

import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddStoryTextScreen extends StatelessWidget {
  TextEditingController captionController = TextEditingController();

  AddStoryTextScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppStates>(
      listener: (context, state) {
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
                  ChatAppCubit.get(context).createStory(
                    dateTime: DateTime.now().toString(),
                    caption: captionController.text,
                  );
                },
                icon: const Icon(
                  Icons.upload,
                ),
              )
            ],
          ),
          body: Container(
            color: Colors.white,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                if (state is ChatAppCreateStoryLoadingState)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: LinearProgressIndicator(),
                  ),
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: Text(
                    ChatAppCubit.get(context).caption,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: deffaultColor,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Spacer(),
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
          ),
        );
      },
    );
  }
}
