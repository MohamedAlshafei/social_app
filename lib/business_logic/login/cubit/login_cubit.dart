import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context)=>BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  })async{
    emit(SocialLoginLoadingState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
  ).then((value) {
    emit(SocialLoginSuccessState(value.user!.uid));
  }).catchError((error){
    emit(SocialLoginErrorState(error.toString()));
  });
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}
  }


  Widget suffix = const Icon(Icons.visibility_outlined);
  bool isPassword = true;

  void changePasswordVisibilty() {
    isPassword = !isPassword;

    suffix = isPassword
        ? const Icon(Icons.visibility_outlined)
        : const Icon(Icons.visibility_off_outlined);

    emit(SocialLoginPasswordVisibilityState());
  }
}
