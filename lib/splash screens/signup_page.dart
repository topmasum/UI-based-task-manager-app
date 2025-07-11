
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/widget/screen_background.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static const String routeName = '/sign-up';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
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
                  Text('Join With Us',
                      style: Theme.of(context).textTheme.titleLarge),
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
                  SizedBox(height: 10),
                  TextFormField(
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'First name',
                      ),
                      validator: (String ? value){
                        if(value?.trim().isEmpty ?? true){
                          return 'Please enter your first name';
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                      controller: _lastnameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Last name',
                      ),
                      validator: (String ? value){
                        if(value?.trim().isEmpty ?? true){
                          return 'Please enter your last name';
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                      controller: _mobileController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Mobile',
                      ),
                      validator: (String ? value){
                        if(value?.trim().isEmpty ?? true){
                          return 'Please enter mobile number';
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                      controller: _passwordController,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Password',
                      ),
                      validator: (String ? value){
                        if((value?.length ?? 0)<=6){
                          return 'Please enter your Password more then 6 character';
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 16,),
                  ElevatedButton(
                      onPressed: _onTapSignupButton,
                      child: Icon(Icons.arrow_circle_right_outlined)),
                  SizedBox(height: 20,),
                  Center(
                    child: Column(
                      children: [
                        //TextButton(onPressed: _onTapForgotButton, child: Text('Forgot Password',style: TextStyle(color: Colors.grey)),),
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
  void _onTapSignupButton(){


  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _mobileController.dispose();
    _lastnameController.dispose();
    super.dispose();
  }


}

