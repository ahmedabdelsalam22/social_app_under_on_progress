import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/module/register/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>{
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context)=>BlocProvider.of(context);


  void userRegister({
    @required String name,
    @required String phone,
    @required String email,
    @required String password
  })
  {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
       print(value.user.email);
       print(value.user.uid);

       userCreate(
         name: name,
         email: email,
         phone: phone,
         uId: value.user.uid,
       );
     // emit(SocialRegisterSuccessState());
    }).catchError((error){
      emit(SocialRegisterErrorState(error.toString()));
    });


  }


  void userCreate({
    @required String name,
    @required String phone,
    @required String email,
    @required String uId
})
{
  emit(SocialCreateUserLoadingState());

  UserModel userModel = UserModel(
    name: name,
    email: email,
    phone: phone,
    uId: uId,
    image: 'https://avatars.githubusercontent.com/u/75587814?s=400&u=185dbb0b60cf484314ea7973106982fe902069e1&v=4',
    bio: 'write your bio..',
    cover: 'https://img.freepik.com/free-photo/impressed-young-man-points-away-shows-direction-somewhere-gasps-from-wonderment_273609-27041.jpg?t=st=1650238690~exp=1650239290~hmac=30cdfed1ee7c6ed136daf995e8f4f083e71d22ed30d111a40b206fdbb37ff9be&w=996',
    isEmailVerified: false
  );

   FirebaseFirestore.instance
       .collection('users')
       .doc(uId).set(userModel.toMap())
       .then((value) {

     emit(SocialCreateUserSuccessState(uId));
   }).catchError((error){
     emit(SocialCreateUserErrorState(error.toString()));
   });
}





  IconData suffix =Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword=!isPassword;
    suffix =isPassword? Icons.visibility_outlined: Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibility());
  }



}