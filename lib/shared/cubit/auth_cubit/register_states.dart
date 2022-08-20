class ChatAppRegisterStates {}

class ChatAppRegisterInitialState extends ChatAppRegisterStates {}

class ChatAppRegisterLoadingState extends ChatAppRegisterStates {}

class ChatAppRegisterSuccessState extends ChatAppRegisterStates {}

class ChatAppRegisterErorrState extends ChatAppRegisterStates {
  final String erorr;

  ChatAppRegisterErorrState(this.erorr);
}

class ChatAppCreateUserLoadingState extends ChatAppRegisterStates {}

class ChatAppCreateUserSuccessState extends ChatAppRegisterStates {}

class ChatAppCreateUserErorrState extends ChatAppRegisterStates {
  final String erorr;

  ChatAppCreateUserErorrState(this.erorr);
}

class ChatAppCreateUserWithGoogleLoadingState extends ChatAppRegisterStates {}

class ChatAppCreateUserWithGoogleSuccessState extends ChatAppRegisterStates {}

class ChatAppCreateUserWithGoogleErorrState extends ChatAppRegisterStates {
  final String erorr;

  ChatAppCreateUserWithGoogleErorrState(this.erorr);
}

class ChatAppVisibilityState extends ChatAppRegisterStates {}
