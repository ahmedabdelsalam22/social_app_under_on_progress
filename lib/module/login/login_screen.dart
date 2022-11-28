import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_screen.dart';
import 'package:social_app/module/register/register_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/cache_helper.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController =TextEditingController();

  var formKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is LoginErrorState)
          {
            showToast(message: 'Login failed', color: Colors.red);
          }
          if(state is LoginSuccessState)
          {
            CacheHelper.saveData(
                key: 'uId',
                value: state.uId,
            ).then((value) {
              navigateToAndFinish(context, const HomeScreen());
            });
          }
        },
        builder: (context,state){

          var cubit = LoginCubit.get(context);

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
                          'LOGIN',
                          style:Theme.of(context).textTheme.headline5.copyWith(
                              fontSize: 35
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'login now to communicate with others',
                          style:Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        const SizedBox(height: 30),
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
                            condition: state is! LoginLoadingState,
                            builder: (context){
                              return defaultButton(
                                text: "LOGIN",
                                onPressed:(){

                                if(formKey.currentState.validate()){
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }

                                },
                              );
                            },
                            fallback: (context)=>const Center(child: CircularProgressIndicator(),)
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            const Text(
                              "I've not an account?",
                            ),
                            defaultTextButton(
                                text: "Register",
                                onPressed: (){
                                  navigateTo(context,SocialRegisterScreen());
                                }
                            ),
                          ],
                        )
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
