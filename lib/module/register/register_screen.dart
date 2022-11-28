import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_screen.dart';
import 'package:social_app/module/register/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constant.dart';
import 'package:social_app/shared/network/cache_helper.dart';

import 'cubit.dart';


class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({Key key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController =TextEditingController();
  var nameController = TextEditingController();
  var phoneController =TextEditingController();

  var formKey =GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SocialRegisterCubit(),

      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context,state){
          if(state is SocialCreateUserSuccessState){
            navigateToAndFinish(context, const HomeScreen());

            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              navigateToAndFinish(context, const HomeScreen());
            });

          }
        },

        builder: (context,state){

          var cubit =SocialRegisterCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style:Theme.of(context).textTheme.headline5.copyWith(
                              fontSize: 35
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Register now to communicate with others',
                          style:Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        const SizedBox(height: 30),
                        defaultFormField(
                            controller:nameController,
                            type:TextInputType.text,
                            labelText: "Name",
                            prefix: Icons.person,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Please Enter Name';
                              }
                            }
                        ),
                        const SizedBox(height: 15),
                        defaultFormField(
                            controller: emailController,
                            type:TextInputType.emailAddress,
                            labelText: "Email Address",
                            prefix: Icons.email_outlined,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Please Enter Email Address';
                              }
                            }
                        ),
                        const SizedBox(height: 15),
                        defaultFormField(
                            controller: phoneController,
                            type:TextInputType.number,
                            labelText: "Number",
                            prefix: Icons.phone,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Please Enter Phone';
                              }
                            }
                        ),
                        const SizedBox(height: 15),

                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            labelText: "Password",
                            isPassword:cubit.isPassword,
                            prefix: Icons.lock,
                            suffix: cubit.suffix,
                            suffixpressed: (){
                              cubit.changePasswordVisibility();
                            },
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Please Enter Password';
                              }
                            }
                        ),
                        const SizedBox(height: 10),
                        ConditionalBuilder(
                            condition: state is! SocialRegisterLoadingState,
                            builder: (context){
                              return defaultButton(
                                text: "Register",
                                onPressed:(){
                                  if(formKey.currentState.validate()){
                                    cubit.userRegister(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                    );
                                  }
                                },
                              );
                            },
                            fallback: (context)=>const Center(child: CircularProgressIndicator(),)
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
