import 'dart:ui';

import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: ChatAppCubit.get(context).defaultTabControllerLength,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              backgroundColor: deffaultColor,
              elevation: 0,
              title: Text(
                ChatAppCubit.get(context)
                    .titles[ChatAppCubit.get(context).currentindex],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                if (ChatAppCubit.get(context).userModel?.image == null)
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740'),

                      //backgroundColor: Colors.grey,
                      radius: 15,
                    ),
                  ),
                if (ChatAppCubit.get(context).userModel?.image != null)
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${ChatAppCubit.get(context).userModel?.image}'),

                      //backgroundColor: Colors.pink,
                      radius: 15,
                    ),
                  )
              ],
              bottom: TabBar(
                padding: const EdgeInsets.only(bottom: 10),
                indicator:
                    const UnderlineTabIndicator(borderSide: BorderSide.none),
                // indicatorColor: Colors.blue,
                onTap: (index) {
                  ChatAppCubit.get(context).changetabBarView(index);
                },
                tabs: ChatAppCubit.get(context).tabs,
              ),
            ),
            body: Container(
              padding: const EdgeInsets.only(top: 15),
              color: deffaultColor,
              child: TabBarView(
                children: ChatAppCubit.get(context).tabBarView,
              ),
            ),
          ),
        );
      },
    );
  }
}
