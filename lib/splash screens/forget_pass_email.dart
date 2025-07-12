
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/widget/screen_background.dart';
class forgetpass extends StatefulWidget {
  const forgetpass({super.key});
  static const String routeName = '/forget_pass';

  @override
  State<forgetpass> createState() => _forgetpassState();
}

class _forgetpassState extends State<forgetpass> {
  final TextEditingController _emailController = TextEditingController();
  //final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen_background(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80,),
                  Text('Your Email Address',
                      style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 4,),
                  Text("Enter a 6 digit pin",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.grey),),
                  SizedBox(height: 24,),
                  TextFormField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Email',
                      ),
                      validator: (String ? value){
                        String email=value ?? '';
                        if(EmailValidator.validate(email)==false){
                          return 'Please enter your email';
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 16,),
                  ElevatedButton(
                      onPressed: _onTapsubmitbutton,
                      child: Icon(Icons.arrow_circle_right_outlined)),
                  SizedBox(height: 20,),
                  Center(
                    child: Column(
                      children: [
                        RichText(text: TextSpan(
                            text: "Have an account?",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                                color: Colors.black
                            ),
                            children:[
                              TextSpan(
                                  text: " Sign In",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                      color: Colors.green
                                  ),
                                  recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton
                              )
                            ]
                        )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
  void _onTapSignInButton(){
 Navigator.pop(context);

  }
  void _onTapsubmitbutton(){
    Navigator.pushNamed(context, '/pin_verification');

  }
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }


}

