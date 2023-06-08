import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/presentation/components/constant.dart';
import 'package:iconly/iconly.dart';

import '../../business_logic/social_layout/cubit/social_cubit.dart';
import '../new_post/new_post_screen.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        if(state is SocialNewPostState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>  NewPost()));
        }
        
      },
      builder: (context, state) {

        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                onPressed: (){}, 
                icon: const Icon(IconlyLight.notification)
                ),
              IconButton(
                onPressed: (){}, 
                icon: const Icon(IconlyLight.search)
                ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            items: const[
              BottomNavigationBarItem(
                icon: Icon(IconlyLight.home),
                label: 'Home'
                ),
              BottomNavigationBarItem(
                icon: Icon(IconlyLight.chat),
                label: 'Chats'
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyLight.upload),
                label: 'Post'
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyLight.location),
                label: 'Users'
                ),
              BottomNavigationBarItem(
                icon: Icon(IconlyLight.setting),
                label: 'Settings'
                ),
            ],
          ),
          );
        
      },
    );
  }
}

// Widget mailAuth(BuildContext context){
//   return ConditionalBuilder(
//             condition: SocialCubit.get(context).model !=null,
//             builder: (context) {

//               var model=SocialCubit.get(context).model;
//               return Column(
//             children: [
//               if(!FirebaseAuth.instance.currentUser!.emailVerified)
//                 Container(
//                   color: Colors.amber.withOpacity(0.6),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20.0
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(
//                           Icons.info_outline
//                         ),
//                         const SizedBox(width: 15.0,),
//                         const Expanded(child: Text('Please Verify Your Mail!.')),
//                         const SizedBox(
//                           width: 15.0,
//                         ),
//                         TextButton(
//                           onPressed: (){
//                             FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
//                               showToast(text: 'check your mail', state: ToastState.success);
//                             }).catchError((error){

//                             });
//                           },
//                           child: Text("Send")
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//             ],
//           );
//             },
//             fallback: (context) => const Center(child: CircularProgressIndicator(),));
// }
