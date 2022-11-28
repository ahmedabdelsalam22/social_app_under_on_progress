import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/model/post_model.dart';
import 'package:social_app/shared/components/components.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return ConditionalBuilder(
            condition: cubit.posts.isNotEmpty && cubit.userModel !=null,
            builder: (context) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5.0,
                      margin: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          const Image(
                            image: NetworkImage(
                                'https://img.freepik.com/free-photo/impressed-young-man-points-away-shows-direction-somewhere-gasps-from-wonderment_273609-27041.jpg?t=st=1650238690~exp=1650239290~hmac=30cdfed1ee7c6ed136daf995e8f4f083e71d22ed30d111a40b206fdbb37ff9be&w=996'),
                            fit: BoxFit.cover,
                            height: 180,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
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
                      itemBuilder: (context, index) {
                        return buildPostItem(
                            cubit.posts[index], context, index);
                      },
                      itemCount: cubit.posts.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8.0),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              );
            },
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }
}

Widget buildPostItem(PostModel postModel, context, index) {
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage:
                    NetworkImage(AppCubit.get(context).userModel.image),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(postModel.name),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 16,
                        )
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      postModel.dateTime,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 16,
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            postModel.text,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          /*Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10),
                    child: Container(
                      height: 20.0,
                      child: MaterialButton(onPressed:(){},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child:const Text('#software',style: TextStyle(color: Colors.blue),),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10),
                    child: Container(
                      height: 20.0,
                      child: MaterialButton(onPressed:(){},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child:const Text('#software',style: TextStyle(color: Colors.blue),),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10),
                    child: Container(
                      height: 20.0,
                      child: MaterialButton(onPressed:(){},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child:const Text('#software',style: TextStyle(color: Colors.blue),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),*/

          if (postModel.postImage != '')
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                height: 145.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: NetworkImage(
                      postModel.postImage,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          size: 16,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                         '${ AppCubit.get(context).likes[index]}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.comment,
                            size: 16,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            '0 comment',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15.0,
                        backgroundImage:
                            NetworkImage(AppCubit.get(context).userModel.image),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'write a comment..',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
              InkWell(
                child: Row(
                  children: [
                    const Icon(
                      Icons.favorite_border,
                      size: 16,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 5.0),
                    Text(
                      'Like',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                onTap: () {
                  AppCubit.get(context)
                      .likePost(AppCubit.get(context).postId[index]);
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
