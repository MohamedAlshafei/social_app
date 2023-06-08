
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/presentation/new_post/new_post_screen.dart';

import '../../../models/message_model/message_model.dart';
import '../../../models/post_model/post_model.dart';
import '../../../models/user_model/user_model.dart';
import '../../../presentation/chats/chats_screen.dart';
import '../../../presentation/components/constant.dart';
import '../../../presentation/feeds/feeds_screen.dart';
import '../../../presentation/settings/settings_screen.dart';
import '../../../presentation/users/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());

  static SocialCubit get(context)=>BlocProvider.of(context);

  UserModel? userModel;

  void getUserData(){

    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users')
    .doc(uId).get()
    .then((value) {
      userModel=UserModel.fromJson(value.data() as Map<String, dynamic>);
      emit(SocialGetUserSuccessState());
    }).catchError((error){
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex=0;
  List<Widget> screens=[
    const FeedsScreen(),
    const ChatsScreen(),
    NewPost(),
    const UsersScreen(),
    const SettingsScreen()
  ];
  List<String> titles=[
    'Home',
    'Chats',
    'Add Post',
    'Users',
    'Settings',
  ];
  void changeBottomNav(int index){
    
    if(index ==1) {
      getAllUsers();
    }
    if(index==2){
      emit(SocialNewPostState());
    }
    else{
      currentIndex=index;
      emit(ChangeBottomNavBarState());
    }
    
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async{
    var pickedFile= await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null){
      profileImage=File(pickedFile.path);
      emit(SocialProfileImageSuccessState());
  }else{
    print('No Image Selected!');
    emit(SocialProfileImageErrorState());
  }
  }

  File? coverImage;
  Future<void> getCoverImage() async{
    var pickedFile= await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null){
      coverImage=File(pickedFile.path);
      emit(SocialCoverImageSuccessState());
  }else{
    print('No Image Selected!');
    emit(SocialCoverImageErrorState());
  }
  }


  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }){
    emit(SocialUpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child(
      'users/${Uri.file(profileImage!.path).pathSegments.last}')
      .putFile(profileImage!).then((value){
        value.ref.getDownloadURL().then((value) {
          // emit(SocialUploadProfileImageSuccessState());
          updateUser(
            name: name, 
            phone: phone, 
            bio: bio,
            image: value
            );
        }).catchError((error){
          emit(SocialUploadProfileImageErrorState());
        });
      }).catchError((error){
          emit(SocialUploadProfileImageErrorState());
      });

  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }){
    emit(SocialUpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child(
      'users/${Uri.file(coverImage!.path).pathSegments.last}')
      .putFile(coverImage!).then((value){
        value.ref.getDownloadURL().then((value) {
          // emit(SocialUploadCoverImageSuccessState());
          updateUser(
            name: name, 
            phone: phone, 
            bio: bio,
            cover: value
            );
        }).catchError((error){
          emit(SocialUploadCoverImageErrorState());
        });
      }).catchError((error){
          emit(SocialUploadCoverImageErrorState());
      });
  }

  // void updateUserImage({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }){
  //   emit(SocialUpdateUserDataLoadingState());

  //   if(coverImage != null){
  //     uploadCoverImage();
  //   }else if(profileImage != null){
  //     uploadProfileImage();
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }){
    UserModel model= UserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      cover: cover??userModel!.cover,
      image: image??userModel!.image,
      uId: userModel!.uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.collection('users').doc(userModel!.uId).update(
      model.toMap()
    ).then((value) {
      getUserData();
    }).catchError((error){
      emit(SocialUpdateUserDataErrorState());
    });
    
  }

  File? postImage;
  Future<void> getPostImage() async{
    var pickedFile= await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null){
      postImage=File(pickedFile.path);
      emit(SocialPickedImageSuccessState());
  }else{
    print('No Image Selected!');
    emit(SocialPickedImageErrorState());
  }
  }
  void removePostImage(){
    postImage=null;
    emit(SocialRemovePostImageState());
  }


  void uploadPostImage({
    required String dateTime,
    required String text,
  }){
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child(
      'users/${Uri.file(postImage!.path).pathSegments.last}')
      .putFile(postImage!).then((value){
        value.ref.getDownloadURL().then((value) {
          createPost(dateTime: dateTime, text: text,postImage: value);
        }).catchError((error){
          emit(SocialCreatePostErrorState());
        });
      }).catchError((error){
          emit(SocialCreatePostErrorState());
      });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }){

    emit(SocialCreatePostLoadingState());

    PostModel model= PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage??'',
      
    );

    //set بيحط تحت دوك معين
    //add بيحط دوك وبعدين يعمل ادد

    FirebaseFirestore.instance.collection('posts').add(
      model.toMap()
    ).then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });
    
  }

  List<PostModel> posts=[];
  List<String> postId=[];
  List<int> likes=[];
  
  
  void getPosts(){
    FirebaseFirestore.instance.collection('posts')
    .get().then((value){
      value.docs.forEach((element) {
        // element.reference
        // .collection('likes')
        // .get()
        // .then((value) {
        //   likes.add(value.docs.length);
          
        // }).catchError((error){});
        postId.add(element.id);
        posts.add(PostModel.fromJson(element.data()));
      });
      emit(SocialGetUserSuccessState());
    }).catchError((error){
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  void likePost(String? postId){
    FirebaseFirestore.instance
    .collection('posts')
    .doc(postId)
    .collection('likes')
    .doc(userModel!.uId)
    .set({
      'like':true,
    })
    .then((value){
      emit(SocialLikePostSuccessState());
    })
    .catchError((error){
      emit(SocialLikePostErrorState());
    });
  }

  List<UserModel> users=[];

  void getAllUsers(){
    if(users.isEmpty){
      emit(SocialGetAllUsersLoadingState());
      FirebaseFirestore.instance.collection('users')
      .get().then((value){
        value.docs.forEach((element) {
          // if(element.data()['uId'] != userModel!.uId)
          // {
          //   users.add(UserModel.fromJson(element.data()));
          // }
          users.add(UserModel.fromJson(element.data()));
        });
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error){
        emit(SocialGetAllUsersErrorState());
      });
    }
  }

  void sendMessage({
    required String reveiverId,
    required String dateTime,
    required String text,
  }){
    MessageModel model= MessageModel(
      senderId: userModel!.uId,
      receiverId: reveiverId,
      dateTime: dateTime,
      text:text
    );
    //set my chats
    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel!.uId)
    .collection('chats')
    .doc(reveiverId)
    .collection('messages')
    .add(model.toMap()).then((value){
      emit(SocialSendMessageSuccessState());
    }).catchError((error){
      emit(SocialSendMessageErrorState());
    });
    
    //set receiver chat
    // FirebaseFirestore.instance
    // .collection('users')
    // .doc(reveiverId)
    // .collection('chats')
    // .doc(userModel!.uId)
    // .collection('messages')
    // .add(model.toMap()).then((value){
    //   emit(SocialSendMessageSuccessState());
    // }).catchError((error){
    //   emit(SocialSendMessageErrorState());
    // });
  }

  List<MessageModel> messages=[];
  void getMessage({
    required String reveiverId
  }){
    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel!.uId)
    .collection('chats')
    .doc(reveiverId)
    .collection('messages')
    .orderBy('dateTime')
    .snapshots()
    .listen((event) {
      messages=[];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }
}
