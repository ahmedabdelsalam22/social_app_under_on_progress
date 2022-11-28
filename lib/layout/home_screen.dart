import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/module/new_post/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/cache_helper.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){
        if(state is BottomNewPostState){
          navigateTo(context,NewPostScreen());
        }
      },
      builder: (context,state){

        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: (){}, icon:const Icon(Icons.notifications_active_outlined)),
              IconButton(onPressed: (){}, icon:const Icon(Icons.search)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.bottomNavChange(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat_outlined),label: 'Chats'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.cloud_upload_outlined),label: 'Posts'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_on_outlined),label: 'Users'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),label: 'Settings'
              ),
            ],
          ),
        );
      },
    );
  }
}
