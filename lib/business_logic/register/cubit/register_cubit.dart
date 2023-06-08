import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model/user_model.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context)=> BlocProvider.of(context);


  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  })async{
    emit(RegisterLoadingState());
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password
    ).then((value){
      // print(value.user!.email);
      // print(value.user!.uid);
      userCreate(name: name, email: email, phone: phone, uId: value.user!.uid);
      // emit(RegisterSuccessState());
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
    
  }){
    UserModel model= UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: "write your bio...",
      image: 'https://img.freepik.com/free-photo/big-sale-discounts-products_23-2150336669.jpg?w=900&t=st=1683877268~exp=1683877868~hmac=0883a5c7ea2ce246f16ff60dcbe3828226a7a873f827bd2d5c469065a2836d72',
      cover: 'https://img.freepik.com/free-photo/soccer-players-action-professional-stadium_654080-1820.jpg?w=826&t=st=1683881296~exp=1683881896~hmac=95025f7fb751084f8d9819036944790bd47ddad005a3de4479e82f198a5ccba2',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error){
      emit(CreateUserErrorState(error.toString()));
    });
  }

  Widget suffix = const Icon(Icons.visibility_outlined);
  bool isPassword = true;

  void changePasswordVisibilty() {
    isPassword = !isPassword;

    suffix = isPassword
        ? const Icon(Icons.visibility_outlined)
        : const Icon(Icons.visibility_off_outlined);

    emit(RegisterPasswordVisibilityState());
  }
}
