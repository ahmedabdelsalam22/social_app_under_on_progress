import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {
   EditProfileScreen({Key key}) : super(key: key);

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){

        var cubit = AppCubit.get(context);
        var userModel = cubit.userModel;

        var profileImage = cubit.profileImage;
        var coverImage = cubit.coverImage;


        nameController.text = userModel.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            text: 'Edit Profile',
            actions: [
              defaultTextButton(
                  text: 'Update',
                  onPressed:(){
                    cubit.updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text
                    );
                  }
              ),
              const SizedBox(width: 10)
            ],
          ),


          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is AppUserUpdateLoadingState)
                  const LinearProgressIndicator(),
                  if(state is AppUserUpdateLoadingState)
                    const SizedBox(height: 10),
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 200,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Container(
                                height: 145.0,width: double.infinity,
                                decoration:  BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0)
                                  ),
                                  image: DecorationImage(
                                    image: coverImage==null? NetworkImage(
                                        userModel.cover
                                    ) : FileImage(coverImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 63.0,
                                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                  child:  CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage: profileImage==null? NetworkImage(
                                        userModel.image
                                    ) : FileImage(profileImage),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    radius: 17.0,
                                    backgroundColor: Colors.blue,
                                    child: IconButton(
                                      onPressed:(){
                                        cubit.getProfileImage();
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.white,
                                        size: 19,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CircleAvatar(
                          radius: 20.0,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                              onPressed:(){
                                cubit.getCoverImage();
                              },
                             icon: const Icon(Icons.camera_alt_outlined,color: Colors.white,),
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if(cubit.profileImage !=null || cubit.coverImage !=null)
                  Row(
                    children: [
                      if(cubit.profileImage !=null)
                      Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                                text: 'upload profile',
                                onPressed: (){
                                  cubit.uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text
                                  );
                                }
                            ),
                            if(state is AppUserUpdateLoadingState)
                              const SizedBox(height: 5),
                            if(state is AppUserUpdateLoadingState)
                              const LinearProgressIndicator(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 7),
                      if(cubit.coverImage !=null)
                      Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                                text: 'upload cover',
                                onPressed: (){
                                  cubit.uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text
                                  );
                                }
                            ),
                            if(state is AppUserUpdateLoadingState)
                              const SizedBox(height: 5),
                            if(state is AppUserUpdateLoadingState)
                              const LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    labelText: 'Name',
                    prefix: Icons.person,
                    validate:(String value){
                      if(value.isEmpty){
                        return 'name must\'t be empty';
                      }return null;
                    },

                  ),
                  const SizedBox(height: 10),
                  defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    labelText: 'Bio',
                    prefix: Icons.short_text,
                    validate:(String value){
                      if(value.isEmpty){
                        return 'Bio must\'t be empty';
                      }return null;
                    },

                  ),
                  const SizedBox(height: 10),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.number,
                    labelText: 'Phone',
                    prefix: Icons.call,
                    validate:(String value){
                      if(value.isEmpty){
                        return 'Phone must\'t be empty';
                      }return null;
                    },

                  ),
                ],
              ),
            ),
          ),


        );
      },
    );
  }
}
