
import 'package:flutter/material.dart';
import 'package:task_manager/splash%20screens/forget_pass_email.dart';
import 'package:task_manager/splash%20screens/forget_pass_pin.dart';
import 'package:task_manager/splash%20screens/password_set.dart';
import 'package:task_manager/splash%20screens/signin_page.dart';
import 'package:task_manager/splash%20screens/signup_page.dart';
import 'package:task_manager/splash%20screens/splash_screen.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

      },
    );
  }
  
}
