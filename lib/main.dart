import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Layout/Shop_App/Shop_Layout.dart';
import 'package:untitled3/Layout/Shop_App/cubit/Shop_Layout_Cubit.dart';
import 'package:untitled3/Layout/Shop_App/states/Shop_Layout_States.dart';
import 'package:untitled3/Layout/social_layout/Cubit/social_cubit.dart';
import 'package:untitled3/Layout/social_layout/social_layout.dart';
import 'package:untitled3/Modules/Shop_App/OnBoarding/On_Bording_Screen.dart';
import 'package:untitled3/Modules/social_app/Login_Screen/SocialLoginScreen.dart';
import 'package:untitled3/components.dart';
import 'package:untitled3/remote/Style.dart';
import 'package:untitled3/remote/blo_observer.dart';
import 'package:untitled3/remote/cubit/cubit.dart';
import 'package:untitled3/remote/dio/casheHelper.dart';


import 'Modules/Shop_App/Login_Screen/ShopLoginScreen.dart';
import 'remote/dio/dio.helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await Diohelper.init() ;
  await cacheHelper.init();
  // var onBoard = cacheHelper.getdata(key: 'onBoarding');
  // token = cacheHelper.getdata(key: 'token');
  uid = cacheHelper.getdata(key: 'uId');
  // print(token);
  Widget widget;

  // if(onBoard != null){
  //   if(token != null) widget = ShopLayout();
  //   else widget = ShopLoginScreen();
  // }
  // else{
  //   widget = OnBoardingScreen();
  // }
  bool isdark = cacheHelper.getdata(key: 'Isdark');
  if(uid != null){
    widget = SocialLayout();
  }else{
    widget = SocialLoginScreen();
  }

  runApp(MyApp(
    widget:widget,
    isdark: isdark,
  ));
}

class MyApp extends StatelessWidget {
  final bool isdark ;
  final Widget widget;

  const MyApp({@required this.widget,this.isdark});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers:
        [
          BlocProvider(create: (context)=>SocialLayoutCubit()..getUserData()..getPosts()),
          BlocProvider(create: (context)=> Newscubit()..onchangeappmode(
            formShared: isdark ,
          )),
          BlocProvider(create: (context)=>ShopLayoutCubit()),
        ],
        child: BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
          listener: (context,state){},
          builder: (context,state){
            var cubit = Newscubit.get(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: light,
              darkTheme: dark,
              // themeMode: cubit.isappmode ? ThemeMode.dark : ThemeMode.light,
              themeMode: ThemeMode.light,
              home: widget,
            );
          },
        )
    );
  }
}
