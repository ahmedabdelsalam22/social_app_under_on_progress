import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/module/chat_details/chat_details_screen.dart';
import 'package:social_app/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.users.isNotEmpty,
          builder: (context){
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index){
                return buildChatItem(cubit.users[index],context);
              },
              separatorBuilder: (context,index){
                return separatedDivider();
              },
              itemCount: cubit.users.length,
            );
          },
          fallback: (context)=>const Center(child:CircularProgressIndicator(),),
        );
      },
    );
  }


  Widget buildChatItem(UserModel user,context)
  {
    return InkWell(
      onTap: (){
        navigateTo(
            context,
            ChatDetailsScreen(userModel: user)
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children:[
            CircleAvatar(
              radius: 25.0,
              backgroundImage:
              NetworkImage(user.image),
            ),
            const SizedBox(width: 15),
            Text(user.name),

          ],
        ),
      ),
    );
  }

}
