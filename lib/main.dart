import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/layout/home_screen.dart';
import 'package:social_app/shared/components/constant.dart';
import 'package:social_app/shared/network/cache_helper.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'layout/cubit/cubit.dart';
import 'module/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await CacheHelper.init();

  Widget widget;
  uId = CacheHelper.getString(key: 'uId');
  print(uId);

  if(uId != null)
  {
    widget = const HomeScreen();
  }else{
    widget = LoginScreen();
  }


  runApp( MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;
   MyApp({Key key, this.startWidget}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AppCubit()..getUserData()..getPosts()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
