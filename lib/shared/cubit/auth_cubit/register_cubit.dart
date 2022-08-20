import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/shared/cubit/auth_cubit/register_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChatAppRegisterCubit extends Cubit<ChatAppRegisterStates> {
  ChatAppRegisterCubit() : super(ChatAppRegisterInitialState());
  static ChatAppRegisterCubit get(context) => BlocProvider.of(context);
  IconData suffex = Icons.visibility_off;
  bool isPassword = true;
  void checkVisibility() {
    isPassword = !isPassword;
    suffex = isPassword ? Icons.visibility_off : Icons.visibility;
    emit(ChatAppVisibilityState());
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
  }) {
    emit(ChatAppRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      createUser(
        name: name,
        email: email,
        uId: value.user!.uid,
      );
      emit(ChatAppRegisterSuccessState());
    }).catchError((erorr) {
      emit(ChatAppRegisterErorrState(erorr));
      print(erorr.toString());
    });
  }

  void signInWithGoogle() async {
    emit(ChatAppCreateUserWithGoogleLoadingState());
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      createUser(
        name: value.user!.displayName.toString(),
        email: value.user!.email.toString(),
        uId: value.user!.uid,
      );
      emit(ChatAppCreateUserWithGoogleSuccessState());
    }).catchError((erorr) {
      emit(ChatAppCreateUserWithGoogleErorrState(erorr));
    });
  }

  void createUser({
    required String name,
    required String email,
    required String uId,
    String? image,
    String? bio,
  }) {
    emit(ChatAppCreateUserLoadingState());
    UserModel userModel = UserModel(
      name: name,
      email: email,
      uId: uId,
      image: image,
      bio: bio,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(ChatAppCreateUserSuccessState());
    }).catchError(((erorr) {
      emit(ChatAppCreateUserErorrState(erorr));
      print(erorr.toString());
    }));
  }
}
