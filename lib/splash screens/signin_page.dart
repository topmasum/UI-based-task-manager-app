import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/splash%20screens/main_nva_holder.dart';
import 'package:task_manager/splash%20screens/signup_page.dart';
import 'package:task_manager/widget/progress_indicator.dart';
import 'package:task_manager/widget/screen_background.dart';
import 'package:task_manager/widget/snackbar_message.dart';

import '../data/Urls.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});
  static const String routeName = '/sign-in';

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signinInprogress = false;

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
                  SizedBox(height: 80),
                  Text(
                    'Get Started with',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Email',
                    ),
                    validator: (String? value) {
                      String email = value ?? '';
                      if (EmailValidator.validate(email) == false) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Password',
                    ),
                    validator: (String? value) {
                      if ((value?.length ?? 0) <= 6) {
                        return 'Please enter your Password more then 6 character';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Visibility(
                    visible: _signinInprogress == false,
                    replacement: progress_indicator(),
                    child: ElevatedButton(
                      onPressed: _onTapSignInButton,
                      child: Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: _onTapForgotButton,
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: " Sign Up",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                  color: Colors.green,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = _onTapSignupButton,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignInButton() {
    if (_formKey.currentState!.validate()) {
      _signin();
    }

  }

  void _onTapForgotButton() {
    Navigator.pushNamed(context, '/forget_pass');
  }

  void _onTapSignupButton() {
    Navigator.pushNamed(context, SignupScreen.routeName);
  }

  Future<void> _signin() async {
    _signinInprogress = true;
    setState(() {});
    Map<String, String> reqbody = {
      'email': _emailController.text.trim(),
      'password': _passwordController.text.trim(),
    };
    NetworkResponse response = await Networkcaller.postRequest(
      url: Url.loginUrl,
      body: reqbody,
    );
    if(response.isSuccess){
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainNvaHolder.routeName,
            (predicate) => false,
      );
    }else{
      _signinInprogress = false;
      setState(() {});
      snackbar_message(context, response.message!);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
