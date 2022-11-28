import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/module/edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){

        var cubit = AppCubit.get(context);
        var userModel = cubit.userModel;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                            image: NetworkImage(
                              userModel.cover
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 63.0,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child:  CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(
                            userModel.image
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                userModel.name,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                userModel.bio,
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '5',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'photos',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '205',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'followings',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '177',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed:(){},
                    child: const Text('Add Photos'),
                    ),
                  ),
                  const SizedBox(width: 5),
                  OutlinedButton(
                    onPressed:(){
                      navigateTo(context, EditProfileScreen());
                    },
                    child: const Icon(Icons.edit_off,size: 17,),
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
