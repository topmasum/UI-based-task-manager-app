import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/splash%20screens/forget_pass_email.dart';
import 'package:task_manager/splash%20screens/forget_pass_pin.dart';
import 'package:task_manager/splash%20screens/main_nva_holder.dart';
import 'package:task_manager/splash%20screens/new_task_screen.dart';
import 'package:task_manager/splash%20screens/password_set.dart';
import 'package:task_manager/splash%20screens/signin_page.dart';
import 'package:task_manager/splash%20screens/signup_page.dart';
import 'package:task_manager/splash%20screens/splash_screen.dart';
import 'package:task_manager/splash%20screens/update_profile_screen.dart';

import 'controller_binder.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});
  static GlobalKey<NavigatorState>navigator=GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigator,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
            contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
            hintStyle: TextStyle(
                color: Colors.grey
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide.none
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none
            ),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide.none
            )

        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(double.maxFinite),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)
              ),
              padding:EdgeInsets.symmetric(vertical: 12),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green
          )
        )
      ),
      initialRoute: '/',
      routes: {
        SplashScreen.routeName:(context) => SplashScreen(),
        SigninScreen.routeName:(context) => SigninScreen(),
        SignupScreen.routeName:(context) => SignupScreen(),
        forgetpass.routeName:(context) => forgetpass(),
        pinverification.routeName:(context) => pinverification(),
        passwordset.routeName:(context) => passwordset(),
        MainNvaHolder.routeName:(context) => MainNvaHolder(),
        newtaskscreen.routeName:(context) => newtaskscreen(),
        update_profile_screen.routeName:(context)=> update_profile_screen(),


      },
      initialBinding: ControllerBinder(),
    );
  }
  
}
