class ChatAppStates {}

class ChatAppInitialState extends ChatAppStates {}

class ChatAppCangeTabBarViewState extends ChatAppStates {}

class ChatAppGetUserLoadingState extends ChatAppStates {}

class ChatAppGetUserSuccessState extends ChatAppStates {}

class ChatAppGetUserErorrState extends ChatAppStates {
  final String erorr;

  ChatAppGetUserErorrState(this.erorr);
}

class ChatAppUpdateUseerLoadingState extends ChatAppStates {}

class ChatAppUpdateUseerSuccessState extends ChatAppStates {}

class ChatAppUpdateUseerErorrState extends ChatAppStates {
  final String erorr;

  ChatAppUpdateUseerErorrState(this.erorr);
}

class ChatAppSignOutLoadingState extends ChatAppStates {}

class ChatAppSignOutSuccessState extends ChatAppStates {}

class ChatAppSignOutErorrState extends ChatAppStates {
  final String erorr;

  ChatAppSignOutErorrState(this.erorr);
}

class ChatAppGetUserImageFromGalleryLoadingState extends ChatAppStates {}

class ChatAppGetUserImageFromGallerySuccessState extends ChatAppStates {}

class ChatAppGetUserImageFromGalleryErorrState extends ChatAppStates {}

class ChatAppGetUserImageFromCameraLoadingState extends ChatAppStates {}

class ChatAppGetUserImageFromCameraSuccessState extends ChatAppStates {}

class ChatAppGetUserImageFromCameraErorrState extends ChatAppStates {}

class ChatAppUploadUserImageFromGalleryLoadingState extends ChatAppStates {}

class ChatAppUploadUserImageFromGallerySuccessState extends ChatAppStates {}

class ChatAppUploadUserImageFromGalleryErorrState extends ChatAppStates {
  final String erorr;

  ChatAppUploadUserImageFromGalleryErorrState(this.erorr);
}

class ChatAppUploadUserImageFromCameraLoadingState extends ChatAppStates {}

class ChatAppUploadUserImageFromCameraErorrState extends ChatAppStates {
  final String erorr;

  ChatAppUploadUserImageFromCameraErorrState(this.erorr);
}

class ChatAppDeleteUserImageSuccessState extends ChatAppStates {}

class ChatAppAddFriendLoadingState extends ChatAppStates {}

class ChatAppAddFriendSuccessState extends ChatAppStates {}

class ChatAppAddFriendErorrState extends ChatAppStates {
  final String erorr;

  ChatAppAddFriendErorrState(this.erorr);
}

class ChatAppGetAllUsersLoadingState extends ChatAppStates {}

class ChatAppGetAllUsersSuccessState extends ChatAppStates {}

class ChatAppGetAllUsersErorrState extends ChatAppStates {
  final String erorr;

  ChatAppGetAllUsersErorrState(this.erorr);
}

class ChatAppGetUserTokeLoadingState extends ChatAppStates {}

class ChatAppGetUserTokeSuccessState extends ChatAppStates {}

class ChatAppGetUserTokeErorrState extends ChatAppStates {
  final String erorr;

  ChatAppGetUserTokeErorrState(this.erorr);
}

class ChatAppSendMessageLoadingState extends ChatAppStates {}

class ChatAppSendMessageSuccessState extends ChatAppStates {}

class ChatAppSendMessageErorrState extends ChatAppStates {
  final String erorr;

  ChatAppSendMessageErorrState(this.erorr);
}

class ChatAppMessagesentSuccessState extends ChatAppStates {}

class ChatAppGetMyDataLoadingState extends ChatAppStates {}

class ChatAppGetMyDataSuccessState extends ChatAppStates {}

class ChatAppGetMyDataErorrState extends ChatAppStates {}

class ChatAppGetMessageSuccessState extends ChatAppStates {}

class ChatAppIsMessageDoubleTapSuccessState extends ChatAppStates {}

class ChatAppGetStoryImageLoadingState extends ChatAppStates {}

class ChatAppGetStoryImageSuccessState extends ChatAppStates {}

class ChatAppGetStoryImageErorrState extends ChatAppStates {}

class ChatAppUploadStoryImageLoadingState extends ChatAppStates {}

class ChatAppUploadStoryImageSuccessState extends ChatAppStates {}

class ChatAppUploadStoryImageErorrState extends ChatAppStates {
  final String erorr;

  ChatAppUploadStoryImageErorrState(this.erorr);
}

class ChatAppCreateStoryLoadingState extends ChatAppStates {}

class ChatAppCreateStorySuccessState extends ChatAppStates {}

class ChatAppCreateStoryErorrState extends ChatAppStates {
  final String erorr;

  ChatAppCreateStoryErorrState(this.erorr);
}

class ChatAppGetStoryLoadingState extends ChatAppStates {}

class ChatAppGetStorySuccessState extends ChatAppStates {}

class ChatAppGetStoryErorrState extends ChatAppStates {
  final String erorr;

  ChatAppGetStoryErorrState(this.erorr);
}

class ChatAppGetUserStoryLoadingState extends ChatAppStates {}

class ChatAppGetUserStorySuccessState extends ChatAppStates {}

class ChatAppGetUserStoryErorrState extends ChatAppStates {
  final String erorr;

  ChatAppGetUserStoryErorrState(this.erorr);
}

class ChatAppChangeCapSuccessState extends ChatAppStates {}

///
class ChatAppGetStoryViewLoadingState extends ChatAppStates {}

class ChatAppGetStoryViewSuccessState extends ChatAppStates {}

class ChatAppGetStoryViewErorrState extends ChatAppStates {
  final String erorr;

  ChatAppGetStoryViewErorrState(this.erorr);
}

class ChatAppDeleatStoryLoadingState extends ChatAppStates {}

class ChatAppDeleatStorySuccessState extends ChatAppStates {}

class ChatAppDeleatStoryErorrState extends ChatAppStates {
  final String erorr;

  ChatAppDeleatStoryErorrState(this.erorr);
}

class ChatAppDeleatStoryCollectionLoadingState extends ChatAppStates {}

class ChatAppDeleatStoryCollectionSuccessState extends ChatAppStates {}

class ChatAppDeleatStoryCollectionErorrState extends ChatAppStates {
  final String erorr;

  ChatAppDeleatStoryCollectionErorrState(this.erorr);
}

class ChatAppDeleatStoryListViewLoadingState extends ChatAppStates {}

class ChatAppDeleatStoryListViewSuccessState extends ChatAppStates {}

class ChatAppDeleatStoryListViewErorrState extends ChatAppStates {
  final String erorr;

  ChatAppDeleatStoryListViewErorrState(this.erorr);
}

class ChatAppAutoDeleatStoryLoadingState extends ChatAppStates {}

class ChatAppAutoDeleatStorySuccessState extends ChatAppStates {}

class ChatAppAutoDeleatStoryErorrState extends ChatAppStates {
  final String erorr;

  ChatAppAutoDeleatStoryErorrState(this.erorr);
}

class ChatAppAutoDeleatStoryCollectionLoadingState extends ChatAppStates {}

class ChatAppAutoDeleatStoryCollectionSuccessState extends ChatAppStates {}

class ChatAppAutoDeleatStoryCollectionErorrState extends ChatAppStates {
  final String erorr;

  ChatAppAutoDeleatStoryCollectionErorrState(this.erorr);
}

class ChatAppStoryViewersLoadingState extends ChatAppStates {}

class ChatAppStoryViewersSuccessState extends ChatAppStates {}

class ChatAppStoryViewersErorrState extends ChatAppStates {
  final String erorr;

  ChatAppStoryViewersErorrState(this.erorr);
}
