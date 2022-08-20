import 'dart:ui';

import 'package:chat_app/layout/layout.dart';
import 'package:chat_app/modules/register_screen/register_screen.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/cubit/auth_cubit/login_cubit.dart';
import 'package:chat_app/shared/cubit/auth_cubit/login_states.dart';
import 'package:chat_app/shared/network/local/cach_helper.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatAppLoginCubit(),
      child: BlocConsumer<ChatAppLoginCubit, ChatAppLoginStates>(
        listener: (context, state) {
          if (state is ChatAppLoginErorrState) {
            showToast(text: state.erorr, state: ToastState.ERORR);
          }
          if (state is ChatAppLoginSuccessState) {
            CachHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              print(state.uId);
              navigateAndFinish(
                context,
                LayoutScreen(),
              );
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10),
                        decoration: deffaultDecoration(
                          bottomEnd: 20,
                          bottomStart: 20,
                          topEnd: 20,
                          topStart: 20,
                          backgroundColor: deffaultColor,
                        ),
                        child: const Text(
                          "Fine App",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      deffaultFormField(
                        controller: emailController,
                        labelText: "Enter Your Email Address ",
                        prefix: Icons.email_outlined,
                      ),
                      const SizedBox(height: 15),
                      deffaultFormField(
                        controller: passwordController,
                        labelText: "Type Your Password",
                        prefix: Icons.password,
                        isPassword: ChatAppLoginCubit.get(context).isPassword,
                        suffix: ChatAppLoginCubit.get(context).suffix,
                        suffixPressed: () {
                          ChatAppLoginCubit.get(context).checkVisibility();
                        },
                      ),
                      const SizedBox(height: 15),
                      deffaultButton(
                          function: () {
                            ChatAppLoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          },
                          text: "login"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          deffaultTextButton(
                            onPressed: () {
                              navigateTo(context, RegisterScreen());
                            },
                            text: 'Sign up',
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
