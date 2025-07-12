import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/splash%20screens/signin_page.dart';
import 'package:task_manager/widget/screen_background.dart';
class pinverification extends StatefulWidget {
  const pinverification({super.key});
  static const String routeName = '/pin_verification';

  @override
  State<pinverification> createState() => _pinverificationState();
}

class _pinverificationState extends State<pinverification> {
  final TextEditingController _otpTEcontroller = TextEditingController();
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
                  Text('PIN Verification',
                      style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 4,),
                  Text("A 6 digit verification has send to your email",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.grey),),
                  SizedBox(height: 24,),
                  PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 50,
                      activeFillColor: Colors.white,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    controller: _otpTEcontroller,
                    appContext: context,
                  ),
                  SizedBox(height: 16,),
                  ElevatedButton(
                      onPressed: _onTapsubmitbutton,
                      child: Text('Verify')),
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
    Navigator.pushNamedAndRemoveUntil(context, SigninScreen.routeName, (predicate)=>false);

  }
  void _onTapsubmitbutton(){
  Navigator.pushNamed(context, '/password_set');
  }
  @override
  void dispose() {
    _otpTEcontroller.dispose();
    super.dispose();
  }


}

