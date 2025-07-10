
import 'package:flutter/material.dart';
import 'package:task_manager/widget/screen_background.dart';
class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen_background(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80,),
              Text('Get Started with',
              style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 24,),
              TextFormField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Email',

                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Password',
                ),
              ),
              SizedBox(height: 16,),
              ElevatedButton(
                  onPressed: (){},
                  child: Icon(Icons.arrow_circle_right_outlined)),
              SizedBox(height: 20,),
              TextButton(onPressed: (){}, child: Text('Forgot Password',style: TextStyle(color: Colors.grey)),),
              RichText(text: TextSpan(
                text: "Don't have an account?",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: Colors.black
                ),
                children:[


                ]
              ))
            ],
          ),
        ),
      ),

    );
  }
}
