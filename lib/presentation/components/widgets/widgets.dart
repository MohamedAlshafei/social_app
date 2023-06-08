import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../business_logic/social_layout/cubit/social_cubit.dart';
import '../../../models/message_model/message_model.dart';
import '../../../models/post_model/post_model.dart';
import '../../../models/user_model/user_model.dart';
import '../../chats/chat_details_screen.dart';

Widget buildPostItem(PostModel model,BuildContext context,index){
  return Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation:5.0,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                          '${model.image}',
                        ),
                      ),
                      const SizedBox(width: 15.0,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                '${model.name}',
                                style: const TextStyle(
                                  height: 1.4
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                                size: 16.0,
                              )
                              ],
                            ),
                            Text(
                              '${model.dateTime}',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                        ),
                        const SizedBox(width: 15.0,),
                        IconButton(
                          onPressed: (){}, 
                          icon: const Icon(Icons.more_horiz),
                          iconSize: 16.0,
                          ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                    ),
                    
                    Text(
                      '${model.text}',
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.3
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        width: double.infinity,
                        child: Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.only(end: 5),
                              child: Container(
                                height: 25.0,
                                child: MaterialButton(
                                  onPressed: (){},
                                  minWidth: 1.0,
                                  padding: EdgeInsets.zero,
                                  child: const Text(
                                    '#software',
                                    style: TextStyle(
                                      color: Colors.blue
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if(model.postImage !='')
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Container(
                          width: double.infinity,
                          height: 140.0,
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                '${model.postImage}'
                        ),
                          fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: Row(
                                  children: [
                                    const Icon(
                                      IconlyLight.heart,
                                      size: 16.0,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(width: 5.0,),
                                    Text(
                                      // '${SocialCubit.get(context).likes[index]}',
                                      '0',
                                      style: Theme.of(context).textTheme.caption!.copyWith(
                                        color: Colors.grey
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: (){},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      IconlyLight.chat,
                                      size: 16.0,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 5.0,),
                                    Text(
                                      '0 comment',
                                      style: Theme.of(context).textTheme.caption!.copyWith(
                                        color: Colors.grey
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: (){},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (){},
                            child: Row(
                              children: [
                                CircleAvatar(
                            radius: 18.0,
                            backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).userModel!.image}'
                            ),
                                                ),
                            const SizedBox(width: 15.0,),
                            Text(
                                  'write a comment..',
                                  style: Theme.of(context).textTheme.caption!.copyWith(
                                    height: 1.4,
                                  ),
                                ),
                                                ],
                            ),
                          ),
                        ),

                        InkWell(
                              child: Row(
                                children: [
                                  const Icon(
                                    IconlyLight.heart,
                                    size: 16.0,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 5.0,),
                                  Text(
                                    'likes',
                                    style: Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.grey
                                    ),
                                  ),
                                ],
                              ),
                              onTap: (){
                                SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
                              },
                            ),
                      ],
                    ),
                ],
              ),
            ),
          );
}

Widget buildMessage(MessageModel model){
  return Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                decoration:  BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: const BorderRadiusDirectional.only(
                    topEnd: Radius.circular(10.0),
                    topStart: Radius.circular(10.0),
                    bottomEnd: Radius.circular(10.0)
                    
                  )
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 10.0
                ),
                child: Text(
                  '${model.text}'
                ),
              ),
            );
}

Widget buildMyMessage(MessageModel model){
  return Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                decoration:  BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: const BorderRadiusDirectional.only(
                    topEnd: Radius.circular(10.0),
                    topStart: Radius.circular(10.0),
                    bottomStart: Radius.circular(10.0)
                    
                  )
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 10.0
                ),
                child: Text(
                  '${model.text}'
                ),
              ),
            );
}

Widget builChatItem(UserModel model,context){
  return InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(
        builder: (context)=>ChatDetailsScreen(
          userModel:model
        )));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
          children:[
            CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
              '${model.image}'
            ),
            ),
            const SizedBox(width: 15.0,),
            Text(
              '${model.name}',
              style: const TextStyle(
                height: 1.4,
                fontWeight: FontWeight.w500,
                fontSize: 16.0
              ),
            ),
          ],
        ),
    ),
  );
}

Widget defualtAppBar({
  required BuildContext context,
  required String title,
  required List<Widget> actions,
}){

  return AppBar(
    leading: IconButton(
      onPressed: (){
        Navigator.pop(context);
      },
      icon: const Icon(IconlyLight.arrow_left),
    ),
    title: Text(title),
    actions: actions,
  );
}