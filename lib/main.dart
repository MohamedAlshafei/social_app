import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/presentation/components/constant.dart';
import 'package:social_app/presentation/layout/home_layout.dart';
import 'package:social_app/presentation/screens/login_screen/login_screen.dart';
import 'package:social_app/presentation/style/theme.dart';

import 'business_logic/bloc_observer.dart';
import 'business_logic/shared_pref/cache_helper.dart';
import 'business_logic/social_layout/cubit/social_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token= FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(text: 'on message', state: ToastState.success);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(text: 'on message opned app', state: ToastState.success);
  });
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  uId= CacheHelper.getData(key: 'uId') ;
  print(uId);
  Widget widget;
  if(uId != null){
    widget= const HomeLayout();
  }else{
    widget = LoginScreen();
  }

  runApp( MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, this.startWidget});
  final Widget? startWidget;


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=> SocialCubit()..getUserData()..getPosts()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        home: startWidget,
      ),
    );
  }
}

