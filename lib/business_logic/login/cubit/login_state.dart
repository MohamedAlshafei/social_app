part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class SocialLoginLoadingState extends LoginState{}
class SocialLoginSuccessState extends LoginState{
  final String uId;
  SocialLoginSuccessState(this.uId);
}
class SocialLoginErrorState extends LoginState{
  final String error;
  SocialLoginErrorState(this.error);
}

class SocialLoginPasswordVisibilityState extends LoginState{}
