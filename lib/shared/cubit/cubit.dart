import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/story_model.dart';
import 'package:chat_app/models/story_viewre_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/modules/chats_Screen/chats_Screen.dart';
import 'package:chat_app/modules/edit_profile/edit_profile.dart';
import 'package:chat_app/modules/favorites_screen/favorites_screen.dart';
import 'package:chat_app/modules/login_screen/login_screen.dart';
import 'package:chat_app/modules/profile_screen/profile_screen.dart';
import 'package:chat_app/modules/status_screen/add_story_screen.dart';
import 'package:chat_app/modules/status_screen/status_screen.dart';
import 'package:chat_app/modules/status_screen/story_views.dart';
import 'package:chat_app/modules/status_screen/test_story.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/components/constatnts.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_Storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_view/story_view.dart';
import 'package:http/http.dart' as http;

class ChatAppCubit extends Cubit<ChatAppStates> {
  ChatAppCubit() : super(ChatAppInitialState());
  static ChatAppCubit get(context) => BlocProvider.of(context);

  //Start of TabBarView
  int defaultTabControllerLength = 4;
  List<Widget> tabs = const [
    Tab(
      child: Text(
        "Status",
        // style: TextStyle(
        //   fontWeight: FontWeight.bold,
        // ),
      ),
    ),
    Tab(
      child: Text(
        "Chats",
        // style: TextStyle(
        //   fontWeight: FontWeight.bold,
        // ),
      ),
    ),
    Tab(
      child: Text(
        "Favorites",
      ),
    ),
    Tab(
      child: Text(
        "Profile",
        // style: TextStyle(
        //   fontWeight: FontWeight.bold,
        // ),
      ),
    ),
  ];
  List<Widget> tabBarView = [
    Container(
      //Status_screen
      decoration: deffaultDecoration(),
      child: StatusScreen(),
    ),
    Container(
      //Chat_screen
      decoration: deffaultDecoration(),
      child: ChatScreen(),
    ),
    Container(
      //Favorites_screen
      decoration: deffaultDecoration(),
      child: FavoritesScreen(),
    ),
    Container(
      //Profile_screen
      decoration: deffaultDecoration(),
      child: ProfileScreen(),
    ),
  ];
  List<String> titles = [
    "Status",
    "Chats",
    "Frinds",
    "Sittings",
  ];
  int currentindex = 0;
  changetabBarView(int index) {
    if (index == 0) {
      //getStory();
      print("Hello From index 0");
    }
    if (index == 1) {
      getAllUsers();
      print("Hello From index 1");
    }
    if (index == 2) {
      getAllUsers();
      print("Hello From index 2");
    }
    if (index == 3) {
      print("Hello From index 3");
    }
    currentindex = index;
    emit(ChatAppCangeTabBarViewState());
  }

//End of TabBarView
  UserModel? userModel;
  void getUserData() {
    emit(ChatAppGetUserLoadingState());
    FirebaseFirestore.instance.collection("users").doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data() as Map<String, dynamic>);
      //print(value.data().toString());
      emit(ChatAppGetUserSuccessState());
    }).catchError((erorr) {
      emit(ChatAppGetUserErorrState(erorr));
    });
  }

  final ImagePicker picker = ImagePicker();
  XFile? userImageFromGallery;
  File? userImageFromGalleryFile;
  Future<void> getUserImageFromGallery() async {
    emit(ChatAppGetUserImageFromGalleryLoadingState());
    userImageFromGallery = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (userImageFromGallery != null) {
      userImageFromGalleryFile = File(userImageFromGallery!.path);
      emit(ChatAppGetUserImageFromGallerySuccessState());
    } else {
      print("please Slect Image");
      emit(ChatAppGetUserImageFromGalleryErorrState());
    }
  }

  //final ImagePicker pickerr = ImagePicker();
  XFile? userImageFromCamera;
  File? userImageFromCameraFile;
  Future getUserImageFromCamera() async {
    emit(ChatAppGetUserImageFromCameraLoadingState());
    userImageFromCamera = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (userImageFromCamera != null) {
      userImageFromCameraFile = File(userImageFromCamera!.path);
      emit(ChatAppGetUserImageFromCameraSuccessState());
    } else {
      print("please Slect Image");
      emit(ChatAppGetUserImageFromCameraErorrState());
    }
  }

  String userImageFromGalleryURL = '';
  void UploudUserImage({
    required String name,
    required String bio,
    String? email,
  }) {
    emit(ChatAppUploadUserImageFromGalleryLoadingState());
    firebase_Storage.FirebaseStorage.instance
        .ref()
        .child(
            "usersImage/${Uri.file(userImageFromGallery!.path).pathSegments.last}")
        .putFile(userImageFromGalleryFile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        userImageFromGalleryURL = value;
        updateUser(
          name: name,
          bio: bio,
          email: email,
          image: value,
        );
        //emit(ChatAppUploadUserImageFromGallerySuccessState());
      }).catchError((erorr) {
        emit(ChatAppUploadUserImageFromGalleryErorrState(erorr));
      });
    }).catchError((erorr) {
      emit(ChatAppUploadUserImageFromGalleryErorrState(erorr));
    });
  }

  String userImageFromCameraURL = '';
  void uploadUserImageFromCamera({
    required String name,
    required String bio,
    String? email,
  }) {
    emit(ChatAppUploadUserImageFromCameraLoadingState());
    firebase_Storage.FirebaseStorage.instance
        .ref()
        .child(
            "usersImage/${Uri.file(userImageFromCamera!.path).pathSegments.last}")
        .putFile(userImageFromCameraFile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        userImageFromCameraURL = value;
        updateUser(
          name: name,
          bio: bio,
          email: email,
          image: value,
        );
      }).catchError((erorr) {
        emit(ChatAppUploadUserImageFromCameraErorrState(erorr));
      });
    }).catchError((erorr) {
      emit(ChatAppUploadUserImageFromCameraErorrState(erorr));
    });
  }

  String imageDeleted =
      "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740";
  void deletUserImage() {
    userModel!.image = null;
    updateUser(
      name: userModel!.name,
      bio: userModel!.bio,
      email: userModel!.email,
      image: imageDeleted,
    );
    emit(ChatAppDeleteUserImageSuccessState());
  }

  void addToFriendList({
    String? name,
    String? email,
    String? image,
    String? bio,
    required String? uId,
  }) {
    emit(ChatAppAddFriendLoadingState());
    UserModel userModelFriendList = UserModel(
      bio: bio,
      email: email,
      image: image,
      name: name,
      uId: uId,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .collection("friendList")
        .add(userModelFriendList.toMap())
        .then((value) {
      emit(ChatAppAddFriendSuccessState());
    }).catchError((erorr) {
      emit(ChatAppAddFriendErorrState(erorr));
    });
  }

  List<UserModel> allUsers = [];
  List<UserModel> usertest = [];
  List<UserModel> myUser = [];
  List<UserModel> allUsersChat = [];
  void getAllUsers() {
    emit(ChatAppGetAllUsersLoadingState());
    List<UserModel> usertest = [];
    allUsers = [];
    myUser = [];
    allUsersChat = [];
    var test2;
    var test3;
    FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.forEach((element) {
        var test = FirebaseFirestore.instance
            .collection("users")
            .doc(element.id)
            .collection("myStories")
            .limit(1)
            .get()
            .then((value) {
          test2 = value.docs.isNotEmpty;
          test3 = value.size;
          FirebaseFirestore.instance
              .collection("users")
              .doc(element.id)
              .update({'stroryExist': test2});

          // FirebaseFirestore.instance
          //     .collection("users")
          //     .doc(element.id)
          //     .collection("myStories")
          //     .doc(element['storyId'])
          //     .update({'stroryExist': value});
          print("*****************************,${value.size}");
          print("*****************************,$test2");
          print("********************************************");
        });

        //if (element['uId'] != uId )
        if (element['stroryExist'] != false) {
          if (element['uId'] != uId) {
            allUsers.add(UserModel.fromJson(element.data()));
          }
        }
        if (element['uId'] == uId) {
          myUser.add(UserModel.fromJson(element.data()));
        }
        if (element['uId'] != uId) {
          allUsersChat.add(UserModel.fromJson(element.data()));
        }
        emit(ChatAppGetAllUsersSuccessState());
      });
    }).catchError((erorr) {
      emit(ChatAppGetAllUsersErorrState(erorr));
    });
  }

  void getUserToken() async {
    emit(ChatAppGetUserTokeLoadingState());
    var myToken = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .update({"myToken": myToken}).then((value) {
      print("myToken: $myToken");
      emit(ChatAppGetUserTokeSuccessState());
    }).catchError((erorr) {
      emit(ChatAppGetUserTokeErorrState(erorr));
      print(erorr.toString());
    });
  }

  void sendMessage({
    required String reciverId,
    required String dateTime,
    required String text,
  }) {
    emit(ChatAppSendMessageLoadingState());
    MessagerModel messagerModel = MessagerModel(
      senderId: userModel!.uId,
      reciverId: reciverId,
      dateTime: dateTime,
      text: text,
    );
    //start my message
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .collection("chats")
        .doc(reciverId)
        .collection("messages")
        .add(messagerModel.toMap())
        .then((value) {
      emit(ChatAppSendMessageSuccessState());
    }).catchError((erorr) {
      emit(ChatAppSendMessageErorrState(erorr));
    });
    //end my message

    //start friend message
    FirebaseFirestore.instance
        .collection("users")
        .doc(reciverId)
        .collection("chats")
        .doc(userModel!.uId)
        .collection("messages")
        .add(messagerModel.toMap())
        .then((value) {
      emit(ChatAppSendMessageSuccessState());
    }).catchError((erorr) {
      emit(ChatAppSendMessageErorrState(erorr));
    });
    //end friend message
  }

  List<MessagerModel> message = [];
  void getMessages({
    required String reciverId,
  }) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .collection("chats")
        .doc(reciverId)
        .collection("messages")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      message = [];
      event.docs.forEach((element) {
        message.add(
          MessagerModel.fromJson(element.data()),
        );
      });
      emit(ChatAppGetMessageSuccessState());
    });
  }

  Future<void> sendNotification(subject, title, token, context) async {
    final postUrl = 'https://fcm.googleapis.com/fcm/send';

    final data = {
      "notification": {"body": subject, "title": title},
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        //'chatID': widget.chatId,
        "status": "done",
        "screen": "chat",
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
      emit(ChatAppMessagesentSuccessState());
    } else {
      print("false");
    }
  }

  void getMyData() {
    emit(ChatAppGetMyDataLoadingState());
    FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.forEach((element) {
        if (element['uId'] == uId) {
          myToken = element['myToken'];
          myName = element['name'];
          myPic = element['image'];
        }
        print("[][][][][][][][][][][][][]][[][][][]][[]][[][][]][][[][]][][]");
        print("myToken is $myToken");
        print("myName is $myName");
        print("myPic is $myPic");
      });
      emit(ChatAppGetMyDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ChatAppGetMyDataErorrState());
    });
  }

  // void getNotifyMessages(context) {
  //   FirebaseMessaging.onMessage.listen((event) {
  //     AwesomeDialog(
  //             context: context,
  //             dialogType: DialogType.INFO,
  //             animType: AnimType.BOTTOMSLIDE,
  //             title: event.notification!.title,
  //             desc: event.notification!.body,
  //             btnOkOnPress: () {})
  //         .show();

  //     print("onMessage");
  //     print(event.data.toString());
  //   });
  //   FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //     AwesomeDialog(
  //             context: context,
  //             dialogType: DialogType.INFO,
  //             animType: AnimType.BOTTOMSLIDE,
  //             title: event.notification!.title,
  //             desc: event.notification!.body,
  //             btnOkOnPress: () {})
  //         .show();
  //     print("onMessageOpenedApp");
  //     print(event.data.toString());
  //   });
  //   Future<void> firebaseMessagingBackgroundHandler(
  //       RemoteMessage message) async {
  //     AwesomeDialog(
  //             context: context,
  //             dialogType: DialogType.INFO,
  //             animType: AnimType.BOTTOMSLIDE,
  //             title: message.notification!.title,
  //             desc: message.notification!.body,
  //             btnOkOnPress: () {})
  //         .show();
  //     print("firebaseMessagingBackgroundHandler");
  //     print(message.data.toString());
  //   }

  //   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // }

  XFile? storyImage;
  File? storyImageFile;
  void getStoryImage(context) async {
    emit(ChatAppGetStoryImageLoadingState());
    storyImage = await picker.pickImage(source: ImageSource.gallery);
    if (storyImage != null) {
      storyImageFile = File(storyImage!.path);
      navigateTo(context, AddStoryScreen(storyImage: storyImageFile!));
      emit(ChatAppGetStoryImageSuccessState());
    } else {
      emit(ChatAppGetStoryImageErorrState());
    }
  }

  void uploadStoryImage({
    String? dateTime,
    String? storyCaption,
  }) {
    emit(ChatAppUploadStoryImageLoadingState());
    firebase_Storage.FirebaseStorage.instance
        .ref()
        .child("stories/${Uri.file(storyImage!.path).pathSegments.last}")
        .putFile(storyImageFile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createStory(
          dateTime: dateTime!,
          storyImage: value,
          caption: storyCaption,
        );
        // emit(ChatAppUploadStoryImageSuccessState());
      }).catchError((erorr) {
        emit(ChatAppUploadStoryImageErorrState(erorr));
      });
    }).catchError((erorr) {
      emit(ChatAppUploadStoryImageErorrState(erorr));
    });
  }

  void createStory({
    required String dateTime,
    String? storyImage,
    String? storyId,
    String? caption,
  }) {
    emit(ChatAppCreateStoryLoadingState());
    StoryModel storyModel = StoryModel(
      uId: userModel!.uId,
      image: userModel!.image,
      name: userModel!.name,
      dateTime: dateTime,
      storyImage: storyImage ?? "",
      storyId: storyId,
      caption: caption ?? "",
    );
    FirebaseFirestore.instance
        //.collection("stories")
        .collection("users")
        .doc(uId)
        .collection("myStories")
        .add(storyModel.toMap())
        .then((value) {
      print("5555555555555555555555555");
      print(value.id);
      FirebaseFirestore.instance
          .collection("users")
          .doc(uId)
          .collection("myStories")
          .doc(value.id)
          .update({'storyId': value.id});
      delete(value.id);
      getStory();
      emit(ChatAppCreateStorySuccessState());
    }).catchError((erorr) {
      emit(ChatAppCreateStoryErorrState(erorr));
    });
  }

  List<StoryModel> story = [];
  void getStory() {
    emit(ChatAppGetStoryLoadingState());
    story = [];
    FirebaseFirestore.instance
        .collection("stories")
        .orderBy("uId")
        /*.doc(uId)
        .collection("myStories")*/
        .get()
        .then((value) {
      value.docs.forEach((element) {
        // if (element['uId'] == "LhOA7zshVmRG2nizaHrBaflHL2s1")
        story.add(StoryModel.fromJson(element.data()));
        print("//////////////////////////////////////////////////////");
        print(story.length);
        emit(ChatAppGetStorySuccessState());
      });
    }).catchError((erorr) {
      emit(ChatAppGetStoryErorrState(erorr));
    });
  }

  List<StoryModel> storyy = [];
  void getStoryy({
    required UserModel userModel,
    context,
  }) {
    emit(ChatAppGetStoryViewLoadingState());
    storyy = [];
    FirebaseFirestore.instance
        .collection("stories")
        .orderBy("uId")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        storyy.add(StoryModel.fromJson(element.data()));
        print("//////////////////////////////////////////////////////");
        print(storyy.length);
        emit(ChatAppGetStoryViewSuccessState());
      });
    }).catchError((erorr) {
      emit(ChatAppGetStoryViewErorrState(erorr));
    }).then((value) {
      navigateTo(
          context,
          TestStory(
            user: userModel,
            myStoryList: userStories,
          ));
    });
  }

  List<StoryModel> userStories = [];
  void getUserStory({
    required UserModel userModel,
    context,
  }) {
    emit(ChatAppGetUserStoryLoadingState());
    userStories = [];
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel.uId)
        .collection("myStories")
        .orderBy("dateTime", descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        userStories.add(StoryModel.fromJson(element.data()));
        print(
            "------------------++++++++++++++++++++++++++------------------------");
        print(userStories.length);
        emit(ChatAppGetUserStorySuccessState());
      });
    }).catchError((erorr) {
      emit(ChatAppGetUserStoryErorrState(erorr));
    }).then((value) {
      navigateTo(
          context,
          TestStory(
            user: userModel,
            myStoryList: userStories,
          ));
    });
  }

  void deleatStory(postid) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .collection("myStories")
        .doc(postid)
        .delete()
        .then((value) {
      //deleatStoryCollection(userModel!.uId, postid);
      emit(ChatAppDeleatStoryLoadingState());
      print("Deleating Srtory");
    }).catchError((erorr) {
      emit(ChatAppDeleatStoryErorrState(erorr));
      print(erorr.toString());
    });
  }

  void deleatStoryCollection(storyPublisher, storyId) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(storyPublisher)
        .collection("myStories")
        .doc(storyId)
        .collection("storyViews")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.delete();
      });
      //deleatStory(storyId);
      //emit(ChatAppDeleatStoryCollectionLoadingState());
      print("Deleating Srtory");
    }).catchError((erorr) {
      emit(ChatAppDeleatStoryCollectionErorrState(erorr));
      print(erorr.toString());
    });
  }

  void delete(postid) {
    emit(ChatAppAutoDeleatStoryLoadingState());
    Future.delayed(const Duration(hours: 1)).then((value) {
      deleatStory(postid);
      emit(ChatAppAutoDeleatStorySuccessState());
    }).catchError((erorr) {
      emit(ChatAppAutoDeleatStoryErorrState(erorr));
      print(erorr.toString());
    });
  }

  void autoDeleteStoryCollection(storyPublisher, storyId) {
    // emit(ChatAppAutoDeleatStoryCollectionLoadingState());
    Future.delayed(const Duration(hours: 1)).then((value) {
      deleatStoryCollection(storyPublisher, storyId);
      //emit(ChatAppAutoDeleatStoryCollectionSuccessState());
    }).catchError((erorr) {
      emit(ChatAppAutoDeleatStoryCollectionErorrState(erorr));
      print(erorr.toString());
    });
  }

  void addStoryViews({
    String? dateTime,
    String? storyImage,
    String? storyId,
    String? caption,
    String? storyPublisher,
  }) {
    //emit(ChatAppStoryViewersLoadingState());
    StoryViewerModel storyViewerModel = StoryViewerModel(
      uId: userModel!.uId,
      image: userModel!.image,
      name: userModel!.name,
      dateTime: dateTime,
      storyImage: storyImage ?? "",
      storyId: storyId,
      caption: caption ?? "",
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(storyPublisher)
        .collection("myStories")
        .doc(storyId)
        .collection("storyViews")
        .doc(uId)
        .set(
          storyViewerModel.toMap(),
          // {
          // "ViewerId": uId,
          // "ViewerName": userModel!.name,
          // "ViewerImage": userModel!.image,
          // "dateTime": dateTime,
          // }
        )
        .then((value) {
      autoDeleteStoryCollection(storyPublisher, storyId);
      //emit(ChatAppStoryViewersLoadingState());
    }).catchError((erorr) {
      //emit(ChatAppStoryViewersErorrState(erorr));

      print(erorr.toString());
    });
  }

  StoryViewerModel? storyViewerModel;
  List<StoryViewerModel> storyViewsModelList = [];
  void getstoryViews(
      {storyDocId, storyPublisherId, StoryModel? storyModel, context}) {
    storyViewsModelList = [];
    emit(ChatAppStoryViewersLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(storyPublisherId)
        .collection("myStories")
        .doc(storyDocId)
        .collection("storyViews")
        .orderBy("dateTime", descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        storyViewsModelList.add(StoryViewerModel.fromJson(element.data()));
      });
      print(storyViewsModelList.length);
      print("666666666666666666666666666666666666666666");
      emit(ChatAppStoryViewersSuccessState());
    }).catchError((error) {
      emit(ChatAppStoryViewersErorrState(error));
    }).then((value) {
      navigateTo(
          context,
          StoryViews(
            myStoryViewsList: storyViewsModelList,
            //userModel: userModel,
            storyModel: storyModel,
          ));
    });
  }

  // List<UserModel> usershaveStories = [];
  // void getUsershaveStories() {
  //   usershaveStories = [];
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(userModel!.uId)
  //       .get()
  //       .then((value) {
  //     value.reference.collection("myStories").limit(1).get().then((value) {
  //       value.docs.forEach((element) {
  //         usershaveStories.add(UserModel.fromJson(element.data()));
  //       });
  //     }).catchError((error) {});
  //     // value.docs.forEach((element) {
  //     //   if (element.exists) {
  //     //     usershaveStories.add(UserModel.fromJson(element.data()));
  //     //   }
  //     // });
  //     print("*********************************");
  //     print(usershaveStories.length);
  //   }).catchError((erorr) {
  //     print(erorr.toString());
  //   });
  // }

  void updateUser({
    required String? name,
    required String? bio,
    String? email,
    String? image,
  }) {
    emit(ChatAppUpdateUseerLoadingState());
    UserModel userModelupdate = UserModel(
      name: name,
      bio: bio,
      email: email,
      image: image ?? userModel!.image,
      uId: uId,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .update(userModelupdate.toMap())
        .then((value) {
      getUserData();
      //emit(ChatAppUpdateUseerSuccessState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(ChatAppUpdateUseerErorrState(erorr));
    });
  }

  bool isMessageDoubleTap = false;
  void likeMessage({var index}) {
    isMessageDoubleTap = !isMessageDoubleTap;
    emit(ChatAppIsMessageDoubleTapSuccessState());
  }

  void signOut(context) {
    emit(ChatAppSignOutLoadingState());
    FirebaseAuth.instance.signOut().then((value) {
      navigateTo(context, LoginScreen());
      emit(ChatAppSignOutSuccessState());
    }).catchError((error) {
      emit(ChatAppSignOutErorrState(error));
    });
  }

  String caption = "";
  void changeCaption(String value) {
    caption = value;
    emit(ChatAppChangeCapSuccessState());
  }
}
