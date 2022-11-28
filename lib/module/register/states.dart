
abstract class SocialRegisterStates{}

class SocialRegisterInitialState extends SocialRegisterStates{}

class SocialRegisterLoadingState extends SocialRegisterStates{}

class SocialRegisterSuccessState extends SocialRegisterStates{}

class SocialRegisterErrorState extends SocialRegisterStates
{
  final String error;
  SocialRegisterErrorState(this.error);
}

class SocialRegisterChangePasswordVisibility extends SocialRegisterStates{}


class SocialCreateUserLoadingState extends SocialRegisterStates{}

class SocialCreateUserSuccessState extends SocialRegisterStates{
  final String uId;
  SocialCreateUserSuccessState(this.uId);
}

class SocialCreateUserErrorState extends SocialRegisterStates
{
  final String error;
  SocialCreateUserErrorState(this.error);
}


