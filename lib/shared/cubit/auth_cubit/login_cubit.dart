import 'package:chat_app/shared/cubit/auth_cubit/login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatAppLoginCubit extends Cubit<ChatAppLoginStates> {
  ChatAppLoginCubit() : super(ChatAppLoginInitialState());
  static ChatAppLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility_off;
  void checkVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off : Icons.visibility;

    emit(ChatAppVisibilityState());
  }

  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(ChatAppLoginLoadingState());

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        emit(ChatAppLoginSuccessState(value.user!.uid));
        print(value.user!.email);
        return value;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      emit(ChatAppLoginErorrState(e.toString()));
    }
  }
}
