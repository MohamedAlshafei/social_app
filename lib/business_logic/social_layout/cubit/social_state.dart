part of 'social_cubit.dart';

@immutable
abstract class SocialState {}

class SocialInitial extends SocialState {}

class SocialGetUserLoadingState extends SocialState{}
class SocialGetUserSuccessState extends SocialState{}
class SocialGetUserErrorState extends SocialState{
  final String error;
  SocialGetUserErrorState(this.error);
}

class SocialGetPostsLoadingState extends SocialState{}
class SocialGetPostsSuccessState extends SocialState{}
class SocialGetPostsErrorState extends SocialState{
  final String error;
  SocialGetPostsErrorState(this.error);
}

class ChangeBottomNavBarState extends SocialState{}
class SocialNewPostState extends SocialState{}

class SocialProfileImageSuccessState extends SocialState{}
class SocialProfileImageErrorState extends SocialState{}

class SocialCoverImageSuccessState extends SocialState{}
class SocialCoverImageErrorState extends SocialState{}

class SocialUploadProfileImageSuccessState extends SocialState{}
class SocialUploadProfileImageErrorState extends SocialState{}

class SocialUploadCoverImageSuccessState extends SocialState{}
class SocialUploadCoverImageErrorState extends SocialState{}

class SocialUpdateUserDataErrorState extends SocialState{}

class SocialUpdateUserDataLoadingState extends SocialState{}

class SocialCreatePostLoadingState extends SocialState{}
class SocialCreatePostSuccessState extends SocialState{}
class SocialCreatePostErrorState extends SocialState{}

class SocialPickedImageSuccessState extends SocialState{}
class SocialPickedImageErrorState extends SocialState{}
class SocialRemovePostImageState extends SocialState{}

class SocialLikePostSuccessState extends SocialState{}
class SocialLikePostErrorState extends SocialState{}

class SocialGetLikePostSuccessState extends SocialState{}
class SocialGetLikePostErrorState extends SocialState{}

class SocialGetAllUsersLoadingState extends SocialState{}
class SocialGetAllUsersSuccessState extends SocialState{}
class SocialGetAllUsersErrorState extends SocialState{}

class SocialSendMessageSuccessState extends SocialState{}
class SocialSendMessageErrorState extends SocialState{}
class SocialGetMessageSuccessState extends SocialState{}
class SocialGetMessageErrorState extends SocialState{}
