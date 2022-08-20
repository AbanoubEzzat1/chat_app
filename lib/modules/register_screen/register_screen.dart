import 'dart:ui';

import 'package:chat_app/modules/login_screen/login_screen.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/cubit/auth_cubit/register_cubit.dart';
import 'package:chat_app/shared/cubit/auth_cubit/register_states.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatAppRegisterCubit(),
      child: BlocConsumer<ChatAppRegisterCubit, ChatAppRegisterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
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
                            controller: nameController,
                            labelText: "Name",
                            prefix: Icons.person,
                            type: TextInputType.name,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Name must not be empt";
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          deffaultFormField(
                            controller: emailController,
                            labelText: "Email",
                            prefix: Icons.email_outlined,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              Pattern pattern =
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                              RegExp emailValidation =
                                  RegExp(pattern.toString());
                              if (!emailValidation.hasMatch(value.toString())) {
                                return "invalid email address";
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          deffaultFormField(
                            isPassword:
                                ChatAppRegisterCubit.get(context).isPassword,
                            controller: passwordController,
                            labelText: "Create Password",
                            prefix: Icons.password,
                            suffix: ChatAppRegisterCubit.get(context).suffex,
                            suffixPressed: () {
                              ChatAppRegisterCubit.get(context)
                                  .checkVisibility();
                            },
                            validate: (value) {
                              Pattern pattern =
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
                              RegExp passwordValidation =
                                  RegExp(pattern.toString());
                              if (!passwordValidation
                                  .hasMatch(value.toString())) {
                                return "password must contains at least 8 characters, one upper case ,one lower case and one digit ";
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          deffaultFormField(
                            isPassword:
                                ChatAppRegisterCubit.get(context).isPassword,
                            controller: retypePasswordController,
                            labelText: "Retype Your Password",
                            prefix: Icons.password,
                            suffix: ChatAppRegisterCubit.get(context).suffex,
                            suffixPressed: () {
                              ChatAppRegisterCubit.get(context)
                                  .checkVisibility();
                            },
                            validate: (value) {
                              if (value != passwordController.text) {
                                return "password doesn't match";
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            decoration: deffaultDecoration(
                              bottomEnd: 20,
                              bottomStart: 20,
                              topEnd: 20,
                              topStart: 20,
                              backgroundColor: deffaultColor,
                            ),
                            child: deffaultTextButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ChatAppRegisterCubit.get(context)
                                      .userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: "Sign up with Email",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            decoration: deffaultDecoration(
                              bottomEnd: 20,
                              bottomStart: 20,
                              topEnd: 20,
                              topStart: 20,
                              backgroundColor: deffaultColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircleAvatar(
                                  radius: 15,
                                  backgroundImage: NetworkImage(
                                      'https://img.freepik.com/free-psd/google-icon-isolated_68185-565.jpg?w=740'),
                                ),
                                deffaultTextButton(
                                  onPressed: () {
                                    ChatAppRegisterCubit.get(context)
                                        .signInWithGoogle();
                                  },
                                  text: "Sign up with google",
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text("By signing up with us, you agree to our"),
                          const Text("Tearms & privacy policy"),
                          //const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              deffaultTextButton(
                                  onPressed: () {
                                    navigateTo(context, LoginScreen());
                                  },
                                  text: 'log in')
                            ],
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
      ),
    );
  }
}
