import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../business_logic/social_layout/cubit/social_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profielImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        phoneController.text = userModel.phone!;
        bioController.text = userModel.bio!;

        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(IconlyLight.arrow_left_2),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text('Edit Profile'),
              titleSpacing: 5.0,
              actions: [
                TextButton(
                    onPressed: () {
                      SocialCubit.get(context).updateUser(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text);
                    },
                    child: const Text('Update')),
                const SizedBox(
                  width: 15.0,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  // const LinearProgressIndicator(),
                  // const SizedBox(
                  //   height: 10.0,
                  // ),
                  Container(
                    height: 185.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 140.0,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5.0)),
                                    image: DecorationImage(
                                      image: coverImage == null
                                          ? NetworkImage('${userModel.cover}')
                                          : FileImage(coverImage)
                                              as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: const CircleAvatar(
                                      radius: 20.0,
                                      child: Icon(
                                        IconlyLight.camera,
                                        size: 20.0,
                                      )),
                                ),
                              ]),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 50.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 45.0,
                                backgroundImage: profielImage == null
                                    ? NetworkImage('${userModel.image}')
                                    : FileImage(profielImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: const CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    IconlyLight.camera,
                                    size: 20.0,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0,),
                  if(SocialCubit.get(context).profileImage !=null ||
                  SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if(SocialCubit.get(context).profileImage !=null)
                          Expanded(
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text, 
                                      bio: bioController.text
                                      );
                                  },
                                  child: const Text('Upload Profile'),
                                ),
                                if(state is SocialUpdateUserDataLoadingState)
                                  const SizedBox(height: 5.0,),
                                if(state is SocialUpdateUserDataLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        const SizedBox(width: 12.0,),
                        if(SocialCubit.get(context).coverImage !=null)
                          Expanded(
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text, 
                                      phone: phoneController.text, 
                                      bio: bioController.text
                                      );
                                  },
                                  child: const Text('Upload Cover'),
                                ),
                                if(state is SocialUpdateUserDataLoadingState)
                                  const SizedBox(height: 5.0,),
                                if(state is SocialUpdateUserDataLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'your name must not be empty';
                      }
                    },
                    decoration: const InputDecoration(
                      label: Text('Name'),
                      prefixIcon: Icon(IconlyLight.user),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'your phone must not be empty';
                      }
                    },
                    decoration: const InputDecoration(
                      label: Text('Phone'),
                      prefixIcon: Icon(IconlyLight.user),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: bioController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'your bio must not be empty';
                      }
                    },
                    decoration: const InputDecoration(
                      label: Text('Bio'),
                      prefixIcon: Icon(IconlyLight.info_circle),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ]),
              ),
            ));
      },
    );
  }
}
