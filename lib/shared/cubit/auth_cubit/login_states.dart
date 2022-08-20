class ChatAppLoginStates {}

class ChatAppLoginInitialState extends ChatAppLoginStates {}

class ChatAppLoginLoadingState extends ChatAppLoginStates {}

class ChatAppLoginSuccessState extends ChatAppLoginStates {
  final String uId;

  ChatAppLoginSuccessState(this.uId);
}

class ChatAppLoginErorrState extends ChatAppLoginStates {
  final String erorr;

  ChatAppLoginErorrState(this.erorr);
}

class ChatAppVisibilityState extends ChatAppLoginStates {}
