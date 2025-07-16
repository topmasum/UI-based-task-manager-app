
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/splash%20screens/signin_page.dart';
import 'package:task_manager/widget/screen_background.dart';
class passwordset extends StatefulWidget {
  const passwordset({super.key});
  static const String routeName = '/password_set';

  @override
  State<passwordset> createState() => _passwordsetState();
}

class _passwordsetState extends State<passwordset> {
  //final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _obscureText1 = true;

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
                  Text('Set Password',
                      style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 4,),
                  Text("Please enter more then 6 character",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.grey),),
                  SizedBox(height: 24,),
                  TextFormField(
                      controller: _passwordTEController,
                      obscureText: _obscureText,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility_off : Icons.visibility,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText; // Toggle visibility
                            });
                          },
                        ),
                      ),
                      validator: (String ? value){
                          if((value?.length ?? 0)<=6){
                            return 'Please enter your Password more then 6 character';
                          }
                          return null;
                        },

                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                      controller: _confirmPasswordTEController,
                      obscureText: _obscureText1,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Confirm Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText1 ? Icons.visibility_off : Icons.visibility,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText1 = !_obscureText1; // Toggle visibility
                            });
                          },
                        ),
                      ),
                      validator: (String ? value){
                        if((value ??'')!=(_passwordTEController.text)){
                          return 'Please enter correct password';
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 16,),
                  ElevatedButton(
                      onPressed: _onTapsubmitbutton,
                      child: Text('Confirm')),
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
    Navigator.pushNamed(context, SigninScreen.routeName);

  }
  void _onTapsubmitbutton(){
    Navigator.pushNamed(context,SigninScreen.routeName);

  }
  @override
  void dispose() {
    _confirmPasswordTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }


}

