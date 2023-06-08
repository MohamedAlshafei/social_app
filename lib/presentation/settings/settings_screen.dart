
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:social_app/business_logic/social_layout/cubit/social_cubit.dart';

import '../edit_profile/edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state){

        var userModel=SocialCubit.get(context).userModel;

        return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 185.0,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Container(
                    width: double.infinity,
                    height: 140.0,
                    decoration:   BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5.0)
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          '${userModel!.cover}'
                        ),
                        fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child:  CircleAvatar(
                      radius: 45.0,
                      backgroundImage: NetworkImage(
                        '${userModel.image}'
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5,),
            Text(
              '${userModel.name}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 5,),
            Text(
              '${userModel.bio}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'Posts',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children: [
                          Text(
                            '50',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'Photos',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children: [
                          Text(
                            '100K',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'Followers',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children: [
                          Text(
                            '5K',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'Followings',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: (){}, 
                    child: const Text(
                      'Add Photos'
                    ),
                    ),
                ),
                const SizedBox(width: 15.0,),
                OutlinedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  EditProfileScreen()));
                    }, 
                    child: const Icon(
                      IconlyLight.edit,
                      size: 18.0,
                    ),
                    ),
              ],
            ),
          ],
        ),
      );
      },
      
    );
  }
}