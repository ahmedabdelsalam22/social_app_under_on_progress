import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/shared/styles/themes.dart';

class ChatDetailsScreen extends StatelessWidget {

  UserModel userModel;
  var messageController = TextEditingController();

  ChatDetailsScreen({Key key, this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(userModel.image),
                ),
                const SizedBox(width: 15.0),
                Text(userModel.name),
              ],
            ),
          ),
          body: Column(
            children: [
              buildMessage(),
              buildMyMessage(),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey[300],
                      width: 1.0
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Row(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'type your message here...'
                      ),
                      controller: messageController,
                    ),
                    Container(
                      height: 50,
                      color: defaultColor,
                      child: MaterialButton(
                        minWidth: 1.0,
                        onPressed: () {
                          cubit.sendMessage(
                              receiverId: userModel.uId,
                              dateTime: DateTime.now().toString(),
                              text: messageController.text
                          );
                        },
                        child: const Icon(
                          Icons.send,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildMessage() =>
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          color: Colors.grey[300],
          padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 5.0
          ),
          decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                bottomEnd: Radius.circular(10.0),
              )
          ),
          child: Text(
              'Hello World'
          ),
        ),
      );

  Widget buildMyMessage() =>
      Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          color: defaultColor.withOpacity(.2),
          padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 5.0
          ),
          decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                bottomStart: Radius.circular(10.0),
              )
          ),
          child: const Text(
              'Hello World'
          ),
        ),
      );


}

