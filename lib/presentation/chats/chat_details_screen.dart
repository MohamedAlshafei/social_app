
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/social_layout/cubit/social_cubit.dart';
import '../../models/user_model/user_model.dart';
import 'package:iconly/iconly.dart';

import '../components/widgets/widgets.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen({super.key, this.userModel} );
  UserModel? userModel;

  var textController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessage(reveiverId: userModel!.uId!);
      
      return BlocConsumer<SocialCubit,SocialState>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            title: Row(
              children:  [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    '${userModel!.image}'
                  ),
                ),
                const SizedBox(width: 15.0,),
                Text(
                  '${userModel!.name}'
                ),
              ],
            ),
          ),
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).messages.isNotEmpty,
            builder: (context){
              return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context,index){
                      var message=SocialCubit.get(context).messages[index];
                      if(SocialCubit.get(context).userModel!.uId == message.senderId) 
                        return buildMyMessage(message);
                      
                      buildMessage(message);
                      
                  
                    },
                    separatorBuilder: (context,index)=>const SizedBox(height: 15.0,),
                    itemCount: SocialCubit.get(context).messages.length,
                  ),
                ),
                
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(15.0)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: textController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type a message..',
                            contentPadding: EdgeInsets.only(left: 5.0)
                          ),
                        ),
                      ),
                      Container(
                        height: 50.0,
                        color: Colors.blue,
                        child: MaterialButton(
                          onPressed: (){
                            SocialCubit.get(context).sendMessage(
                              reveiverId: userModel!.uId!, 
                              dateTime: DateTime.now().toString(), 
                              text: textController.text
                              );
                          },
                          minWidth: 1.0,
                          child: const Icon(
                            IconlyBold.send,
                            size: 18,
                            color: Colors.white,
                          ),
                          ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
            },
            fallback: (context)=> const Center(child: CircularProgressIndicator()),
          )
        );
        },
        
      );
      },
    );
  }
}