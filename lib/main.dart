import 'package:chat_app/layout/layout.dart';
import 'package:chat_app/modules/login_screen/login_screen.dart';
import 'package:chat_app/my_block_observer.dart';
import 'package:chat_app/services/local_notification.dart';
import 'package:chat_app/shared/components/constatnts.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:chat_app/shared/network/local/cach_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  LocalNotificationService.showNotificationOnForeground(message);
  print("firebaseMessagingBackgroundHandler");
  print(message.data.toString());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getToken();
  LocalNotificationService.initilize();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((event) {
    LocalNotificationService.showNotificationOnForeground(event);
    print("onMessage");
    print(event.data.toString());
    // AlertDialog(
    //   title: const Text("Notificatio"),
    //   content: Text(event.notification!.body!),
    // );
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    LocalNotificationService.showNotificationOnForeground(event);
    print("onMessageOpenedApp");
    print(event.data.toString());
    //showToast(text: "onMessageOpenedApp", state: ToastState.SUCCESS);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  BlocOverrides.runZoned(
    () async {
      await CachHelper.init();
      late Widget widget;
      uId = CachHelper.getData(key: 'uId');
      print(uId);
      if (uId != null) {
        widget = LayoutScreen();
      } else {
        widget = LoginScreen();
      }
      runApp(MyApp(initialWidget: widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  late final Widget initialWidget;
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "Main Navigator"); //

  MyApp({required this.initialWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChatAppCubit()
            ..getUserToken()
            ..getUserData()
            ..getAllUsers()
            ..getStory()
            ..getMyData(),
        )
      ],
      child: BlocConsumer<ChatAppCubit, ChatAppStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home:
              //Home()
              initialWidget,
          //LoginScreen(),
          //RegisterScreen(),
          //LayoutScreen(),
        ),
      ),
    );
  }
}
