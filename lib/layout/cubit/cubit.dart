import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/model/message_model.dart';
import 'package:social_app/model/post_model.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/module/chats/chats_screen.dart';
import 'package:social_app/module/feeds/feeds_screen.dart';
import 'package:social_app/module/new_post/new_post_screen.dart';
import 'package:social_app/module/settings/settings_screen.dart';
import 'package:social_app/module/users/users_screen.dart';
import 'package:social_app/shared/components/constant.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());


  static AppCubit get(context)=>BlocProvider.of(context);

  
  UserModel userModel;
  
  void getUserData()
  {
    emit(GetUserLoadingState());
    
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
          print(value.data());
          userModel = UserModel.fromJson(value.data());
          emit(GetUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetUserErrorState(error.toString()));
    });
  }
  

  int currentIndex = 0;

  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    NewPostScreen(),
    const UsersScreen(),
    const SettingsScreen()
  ];

  List<String> titles = [
    'Feeds',
    'Chats',
    'Post',
    'Users',
    'Settings'
  ];


  void bottomNavChange(int index)
  {
    if(index==1)
    {
      getUsers();
    }

    if(index==2) {
      emit(BottomNewPostState());
    } else {
      currentIndex = index;
      emit(BottomNavChangeState());
    }
  }


  File profileImage;

  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(AppProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AppProfileImagePickedErrorState());
    }
  }

  File coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(AppCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AppCoverImagePickedErrorState());
    }
  }



  void uploadProfileImage({
    @required String name,
    @required String phone,
    @required String bio,
})
  {
    emit(AppUserUpdateLoadingState());

    firebase_storage.FirebaseStorage
        .instance.ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      print(value.ref.getDownloadURL().then((value) {
        print(value);

        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value
        );
       // emit(AppUploadProfileImageSuccessState());
      }).catchError((error){
        emit(AppUploadProfileImageErrorState());
      }));
    }).catchError((error){
      emit(AppUploadProfileImageErrorState());
    });

  }


  void uploadCoverImage({
    @required String name,
    @required String phone,
    @required String bio,
})
  {
    emit(AppUserUpdateLoadingState());

    firebase_storage.FirebaseStorage
        .instance.ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      print(value.ref.getDownloadURL().then((value) {
        print(value);

        updateUser(
            name: name,
            phone: phone,
            bio: bio,
            cover: value
        );
        emit(AppUploadCoverImageSuccessState());
      }).catchError((error){
        emit(AppUploadCoverImageErrorState());
      }));
    }).catchError((error){
      emit(AppUploadCoverImageErrorState());
    });

  }

/*
  void updateUserImages({
  @required String name,
    @required String phone,
    @required String bio,

  })
  {
   emit(AppUserUpdateLoadingState());

    if(coverImage != null){
      uploadCoverImage();
    }else if(profileImage != null){
      uploadProfileImage();
    }else if(coverImage != null && profileImage != null){

    }
    else{

      updateUser(
        name: name,
        phone: phone,
        bio: bio
      );

    }

  }
*/

  void updateUser({
    @required String name,
    @required String phone,
    @required String bio,
    String cover,
    String image
})
  {
    UserModel model = UserModel(
        name: name,
        phone: phone,
        uId: uId,
        bio: bio,
        email: userModel.email,
        image: image??userModel.image,
        cover: cover??userModel.cover,
        isEmailVerified: false
    );

    FirebaseFirestore.instance.collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error){
      emit(AppUserUpdateErrorState());
    });
  }


//// posts


  File postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(AppPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AppPostImagePickedErrorState());
    }
  }

  void removePostImage()
  {
    postImage = null;
    emit(AppRemovePostImageState());
  }


  void uploadPostImage({
    @required String dateTime,
    @required String text,
  })
  {
    emit(AppCreatePostLoadingState());

    firebase_storage.FirebaseStorage
        .instance.ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      print(value.ref.getDownloadURL().then((value) {
        print(value);

        createPost(
            dateTime: dateTime,
            text: text,
          postImage: value,
        );
        emit(AppCreatePostSuccessState());
      }).catchError((error){
        emit(AppCreatePostErrorState());
      }));
    }).catchError((error){
      emit(AppCreatePostErrorState());
    });

  }


  void createPost({
    @required String dateTime,
    @required String text,
    String postImage
  })
  {
    emit(AppCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel.name,
      uId: userModel.uId,
      image: userModel.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage??''
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(AppCreatePostSuccessState());
    }).catchError((error){
      emit(AppCreatePostErrorState());
    });
  }


  List<PostModel> posts =[];
  List<String> postId =[];
  List<int> likes = [];

  void getPosts()
  {
     FirebaseFirestore.instance
     .collection('posts')
     .get()
     .then((value) {
       value.docs.forEach((element) {

         //num of likes
         element.reference
         .collection('likes')
         .get()
         .then((value) {
           likes.add(value.docs.length);
           postId.add(element.id);
           posts.add(PostModel.fromJson(element.data()));

         }).catchError((error){

         });


       });
       emit(GetPostSuccessState());
     }).catchError((error){
       emit(GetPostErrorState(error.toString()));
     });
  }


  void likePost(String postId)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uId)
        .set({
      'like':true
    })
        .then((value) {
        emit(LikePostSuccessState());
    }).catchError((error){
      emit(LikePostErrorState(error.toString()));
    });
  }



  List<UserModel> users;

  void getUsers()
  {
    if(users.isEmpty) {
      FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
      value.docs.forEach((element) {

        if(element.data()['uId'] != userModel.uId) {
          users.add(UserModel.fromJson(element.data()));
        }
 
      });
      emit(GetAllUserSuccessState());
    }).catchError((error){
      emit(GetAllUserErrorState(error.toString()));
    });
    }
  }


  void sendMessage({
  @required String receiverId,
   @required String dateTime,
    @required String text,
})
  {

    MessageModel model = MessageModel(
      senderId: userModel.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      text: text
    );

    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .add(model.toMap())
    .then((value) {

      emit(SendMessageSuccessState());
    }).catchError((error){
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {

      emit(SendMessageSuccessState());
    }).catchError((error){
      emit(SendMessageErrorState());
    });


  }





}
