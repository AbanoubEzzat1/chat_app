import 'dart:io';

import 'package:chat_app/modules/profile_screen/profile_screen.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppStates>(
      listener: (context, state) {
        if (state is ChatAppGetUserImageFromGallerySuccessState) {
          Navigator.pop(context);
        }
        if (state is ChatAppGetUserSuccessState) {
          ChatAppCubit.get(context).userImageFromGallery = null;
        }

        if (state is ChatAppGetUserImageFromCameraSuccessState) {
          Navigator.pop(context);
        }
        if (state is ChatAppGetUserSuccessState) {
          ChatAppCubit.get(context).userImageFromCamera = null;
        }
        if (state is ChatAppDeleteUserImageSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var userModel = ChatAppCubit.get(context).userModel;
        nameController.text = userModel!.name ?? "Gest";
        aboutController.text = userModel.bio != null
            ? userModel.bio!
            : "Hey there i am using FineApp";
        emailController.text = userModel.email!;
        var userImageFile =
            ChatAppCubit.get(context).userImageFromGalleryFile ??
                ChatAppCubit.get(context).userImageFromCameraFile;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
            toolbarHeight: 100,
            centerTitle: true,
            elevation: 0,
            backgroundColor: deffaultColor,
          ),
          body: SingleChildScrollView(
            child: Container(
              color: deffaultColor,
              width: double.infinity,
              child: Container(
                decoration: deffaultDecoration(
                  backgroundColor: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            if (ChatAppCubit.get(context).userModel!.image !=
                                null)
                              CircleAvatar(
                                backgroundImage: userImageFile == null
                                    ? NetworkImage(
                                        "${ChatAppCubit.get(context).userModel!.image}")
                                    : FileImage(userImageFile) as ImageProvider,
                                radius: 60,
                              ),
                            if (ChatAppCubit.get(context).userModel!.image ==
                                null)
                              const CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740"),
                                radius: 60,
                              ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                end: 6,
                              ),
                              child: CircleAvatar(
                                child: IconButton(
                                  onPressed: () {
                                    showModel(context);
                                  },
                                  icon: const Icon(Icons.camera_alt_rounded),
                                ),
                                radius: 19,
                              ),
                            ),
                          ],
                        ),
                        //const SizedBox(height: 5),
                        if (ChatAppCubit.get(context).userImageFromGallery !=
                                null ||
                            ChatAppCubit.get(context).userImageFromCamera !=
                                null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  ChatAppCubit.get(context)
                                      .userImageFromGallery = null;
                                  ChatAppCubit.get(context)
                                      .userImageFromCamera = null;
                                  navigateTo(context, EditProfileScreen());
                                },
                                icon: const Icon(
                                  Icons.cancel_outlined,
                                  size: 30,
                                  color: Colors.blue,
                                ),
                              ),
                              deffaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    if (ChatAppCubit.get(context)
                                            .userImageFromGallery !=
                                        null) {
                                      ChatAppCubit.get(context).UploudUserImage(
                                        name: nameController.text,
                                        bio: aboutController.text,
                                        email: emailController.text,
                                      );
                                    }
                                    if (ChatAppCubit.get(context)
                                            .userImageFromCamera !=
                                        null) {
                                      ChatAppCubit.get(context)
                                          .uploadUserImageFromCamera(
                                        name: nameController.text,
                                        bio: aboutController.text,
                                        email: emailController.text,
                                      );
                                    }
                                  }

                                  // ChatAppCubit.get(context).userImageFromGallery =
                                  //     null;

                                  // if (state is ChatAppGetUserLoadingState) {
                                  //   print("55555555555555555555555555555555555");
                                  //   ChatAppCubit.get(context).userImageFromGallery =
                                  //       null;
                                  // }

                                  // if (state is ChatAppGetUserSuccessState) {
                                  //   ChatAppCubit.get(context).userImageFromGallery =
                                  //       null;
                                  // }
                                  // ChatAppCubit.get(context).userImageFromGallery ==
                                  //     null;
                                  // if (state is ChatAppGetUserSuccessState) {
                                  //   Navigator.pop(context);
                                  //   ChatAppCubit.get(context)
                                  //           .userImageFromGallery ==
                                  //       null;
                                  //   // ChatAppCubit.get(context).userModel!.image ==
                                  //   //     null;
                                  // }
                                },
                                text: state is ChatAppUploadUserImageFromGalleryLoadingState ||
                                        state
                                            is ChatAppUploadUserImageFromCameraLoadingState
                                    ? "loading..."
                                    : 'Upload image',
                              ),
                            ],
                          ),
                        const SizedBox(height: 20),
                        deffaultFormField(
                          controller: nameController,
                          labelText: 'Name',
                          prefix: Icons.person,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Name can't be embty";
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        deffaultFormField(
                          controller: aboutController,
                          labelText: 'About',
                          prefix: Icons.emoji_emotions,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "About can't be embty";
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        deffaultFormField(
                          controller: emailController,
                          labelText: 'Email',
                          prefix: Icons.email_rounded,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Email can't be embty";
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        deffaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ChatAppCubit.get(context).updateUser(
                                name: nameController.text,
                                bio: aboutController.text,
                                email: emailController.text,
                              );
                            }
                          },
                          text: state is ChatAppUpdateUseerLoadingState
                              ? 'loading...'
                              : 'Update',
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

void showModel(context) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.only(
        topStart: Radius.circular(20),
        topEnd: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (context) {
      return Container(
        // decoration: const BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadiusDirectional.only(
        //     topStart: Radius.circular(20),
        //     topEnd: Radius.circular(20),
        //   ),
        // ),
        height: 255,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Delete Photo"),
                        content: const Text(
                            'Are you sure you want to delete your profile photo?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              ChatAppCubit.get(context).deletUserImage();
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Center(
                  heightFactor: 3,
                  child: Text(
                    'Delete Photo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),
              InkWell(
                onTap: () {
                  ChatAppCubit.get(context).getUserImageFromCamera();
                },
                child: Center(
                  heightFactor: 3,
                  child: Text(
                    'Take Photo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: deffaultColor,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),
              InkWell(
                onTap: () {
                  ChatAppCubit.get(context).getUserImageFromGallery();
                },
                child: Center(
                  heightFactor: 3,
                  child: Text(
                    'Choose Photo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: deffaultColor,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  heightFactor: 3,
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: deffaultColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
