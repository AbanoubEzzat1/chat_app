// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:chat_app/modules/chats_Screen/chats_Screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final GlobalKey<NavigatorState> localnavigatorKey = GlobalKey();
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initilize() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _notificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: selectNotification,
      // onSelectNotification: (String? payload) {
      //   print(payload);
      // },
    );
  }

  static void showNotificationOnForeground(RemoteMessage message) {
    //String screen = message.data['screen'];
    final notificationDetail = NotificationDetails(
        android: AndroidNotificationDetails(
      "com.example.chat_app",
      "chat_app",
      importance: Importance.max,
      priority: Priority.high,
    ));

    _notificationsPlugin.show(
      DateTime.now().microsecond,
      message.notification!.title,
      message.notification!.body,
      notificationDetail,
      payload: message.data.toString(),
    );
  }

  static Future selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    print("1111111111 $payload");
    // localnavigatorKey.currentState!
    //     .push(MaterialPageRoute<void>(builder: (context) => ChatScreen()));
  }

//     static Future<dynamic> onSelectNotification(payload) async {
// // navigate to booking screen if the payload equal BOOKING
//     if (payload == "chat") {
//       navigatorKey.currentState!.pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => ChatScreen()),
//         (Route<dynamic> route) => false,
//       );
//     }
//   }

}
