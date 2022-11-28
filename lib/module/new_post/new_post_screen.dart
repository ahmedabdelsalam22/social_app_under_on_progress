import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

class NewPostScreen extends StatelessWidget {
   NewPostScreen({Key key}) : super(key: key);

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){

        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            text: 'Create Post',
            actions: [
              defaultTextButton(
                  text: 'Post',
                  onPressed: (){

                    var now = DateTime.now();

                    if(cubit.postImage==null){
                      cubit.createPost(
                          dateTime: now.toString(),
                          text: textController.text
                      );
                    }else{
                      cubit.uploadPostImage(
                          dateTime: now.toString(),
                          text: textController.text
                      );
                    }
                  }
              ),
            ],
          ),

          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is AppCreatePostLoadingState)
                const LinearProgressIndicator(),
                if(state is AppCreatePostLoadingState)
                  const SizedBox(height: 10),
                Row(
                  children: const [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          'https://avatars.githubusercontent.com/u/75587814?s=400&u=185dbb0b60cf484314ea7973106982fe902069e1&v=4'
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child:Text('Ahmed Abd Elsalam'),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'whats in your mind...',
                      border: InputBorder.none
                    ),
                  ),
                ),
                if(cubit.postImage !=null)
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
                                  borderRadius: BorderRadius.circular(4.0),
                                  image: DecorationImage(
                                    image: FileImage(cubit.postImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
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
                              cubit.removePostImage();
                            },
                            icon: const Icon(Icons.close,color: Colors.white,),
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: (){
                          cubit.getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.image),
                            SizedBox(width: 5),
                            Text('Add Photo'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child: const Text('#tags'),
                      ),
                    ),
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
