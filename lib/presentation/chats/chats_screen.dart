import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/social_layout/cubit/social_cubit.dart';
import '../components/widgets/widgets.dart';
class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (context) {
            return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context,index)=>builChatItem(SocialCubit.get(context).users[index],context), 
        separatorBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Container(
              height: 1.0,
              color: Colors.grey[400],
            ),
          );
        }, 
        itemCount: SocialCubit.get(context).users.length,
        );
          },
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}