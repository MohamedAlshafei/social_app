

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../business_logic/social_layout/cubit/social_cubit.dart';
import '../components/widgets/widgets.dart';

class NewPost extends StatelessWidget {
  NewPost({super.key});
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
          actions: [
            TextButton(
              onPressed: (){
                var dateTime= DateTime.now();
                if(SocialCubit.get(context).postImage == null){
                  SocialCubit.get(context).createPost(
                    dateTime: dateTime.toString(), 
                    text: textController.text
                    );
                }else{
                  SocialCubit.get(context).uploadPostImage(
                    dateTime: dateTime.toString(), 
                    text: textController.text
                    );
                }
              }, 
              child: const Text(
                'Post'
              ),
              ),
          ],
        ),
            
        
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              if(state is SocialCreatePostLoadingState)
                const LinearProgressIndicator(),
              if(state is SocialCreatePostLoadingState)
                const SizedBox(height: 5.0,),
              Row(
                children: [
                  const CircleAvatar(
                            radius: 25.0,
                            backgroundImage: NetworkImage(
                              'https://img.freepik.com/premium-photo/arabic-calligraphy-wallpaper-white-wall-with-overlapping-old-paper-background_430468-234.jpg?w=740',
                
                            ),
                          ),
                  const SizedBox(width: 15.0,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children:const [
                            Text(
                              'Mohamed Alshafey',
                              style: TextStyle(
                                height: 1.4
                              ),
                            ),
                          SizedBox(width: 5,),
                          ],
                        ),
                      ],
                    ),
                    ),
                ],
              ),
    
              Expanded(
                child: TextFormField(
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: 'write a post ...',
                    border: InputBorder.none
                  ),
                ),
              ),
              const SizedBox(height: 20.0,),
              if(SocialCubit.get(context).postImage !=null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 140.0,
                        decoration: BoxDecoration(
                        borderRadius:  BorderRadius.circular(4),
                        image: DecorationImage(
                        image: FileImage(SocialCubit.get(context).postImage!) ,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        SocialCubit.get(context).removePostImage();
                      },
                      icon: const CircleAvatar(
                        radius: 20.0,
                        child: Icon(
                          IconlyLight.close_square,
                          size: 20.0,
                        )),
                      ),
                ]),
              const SizedBox(height: 20.0,),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: (){
                        SocialCubit.get(context).getPostImage();
                      }, 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const[
                          Icon(IconlyBroken.image),
                          SizedBox(width: 5,),
                          Text('add photo!'),
                        ],
                      ),
                      ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: (){},
                      child: const Text('# tags'),
                    ),
                  )
                ],
              ),

            ],
          ),
        ),
      );
      },
    );
  }
}