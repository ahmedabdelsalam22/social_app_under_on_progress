abstract class AppStates{}

class AppInitialState extends AppStates{}

class GetUserLoadingState extends AppStates{}

class GetUserSuccessState extends AppStates{}

class GetUserErrorState extends AppStates{
  final String error;

  GetUserErrorState(this.error);

}

class BottomNavChangeState extends AppStates{}

class BottomNewPostState extends AppStates{}

class AppProfileImagePickedSuccessState extends AppStates{}

class AppProfileImagePickedErrorState extends AppStates{}

class AppCoverImagePickedSuccessState extends AppStates{}

class AppCoverImagePickedErrorState extends AppStates{}

class AppUploadProfileImageSuccessState extends AppStates{}

class AppUploadProfileImageErrorState extends AppStates{}

class AppUploadCoverImageSuccessState extends AppStates{}

class AppUploadCoverImageErrorState extends AppStates{}

class AppUserUpdateErrorState extends AppStates{}

class AppUserUpdateLoadingState extends AppStates{}

class AppCreatePostLoadingState extends AppStates{}

class AppCreatePostSuccessState extends AppStates{}

class AppCreatePostErrorState extends AppStates{}

class AppPostImagePickedSuccessState extends AppStates{}

class AppPostImagePickedErrorState extends AppStates{}

class AppRemovePostImageState extends AppStates{}

class GetPostLoadingState extends AppStates{}

class GetPostSuccessState extends AppStates{}

class GetPostErrorState extends AppStates{
  final String error;

  GetPostErrorState(this.error);

}



class LikePostSuccessState extends AppStates{}

class LikePostErrorState extends AppStates{
  final String error;

  LikePostErrorState(this.error);

}


class GetAllUserLoadingState extends AppStates{}

class GetAllUserSuccessState extends AppStates{}

class GetAllUserErrorState extends AppStates{
  final String error;

  GetAllUserErrorState(this.error);

}

class SendMessageSuccessState extends AppStates{}

class SendMessageErrorState extends AppStates{}

class GetMessageSuccessState extends AppStates{}

class GetMessageErrorState extends AppStates{}


class SignOutState extends AppStates{}