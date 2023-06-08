
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../business_logic/social_layout/cubit/social_cubit.dart';
import '../components/widgets/widgets.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: ((context, state) {
        
      }),
      builder: (context,state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty && SocialCubit.get(context).userModel !=0,
          builder: (context){
            return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation:5.0,
              margin: const EdgeInsets.all(8),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  const Image(
                  image:  NetworkImage(
                    'https://img.freepik.com/free-photo/smiling-doctor-with-strethoscope-isolated-grey_651396-974.jpg?w=740&t=st=1683594420~exp=1683595020~hmac=8bcc17f0cc38de089e197d2d45ebe7852ce2c5be1b01c9b0912dab7465b0ae76',
                    
                  ),
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: 200.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'communicate with friends',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ],
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return buildPostItem(SocialCubit.get(context).posts[index],context,index);
              }, 
              separatorBuilder: (context,index){
                return const SizedBox(
                  height: 8,
                );
              }, 
              itemCount: SocialCubit.get(context).posts.length,
              ),
            const SizedBox(height: 8.0,),
          ],
        ),
      );
          },
          fallback: (context)=>const Center(child:  CircularProgressIndicator()),
        );
      },
      
    );
  }
}