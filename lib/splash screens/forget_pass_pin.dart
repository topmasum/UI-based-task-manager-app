import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/splash%20screens/password_set.dart';
import 'package:task_manager/splash%20screens/signin_page.dart';
import 'package:task_manager/widget/screen_background.dart';

import '../ui/controllers/pin_verification_controller.dart';

class pinverification extends StatefulWidget {
  const pinverification({super.key});
  static const String routeName = '/pin_verification';

  @override
  State<pinverification> createState() => _pinverificationState();
}

class _pinverificationState extends State<pinverification> {
  final TextEditingController _otpTEcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String email;
  final PinVerificationController _controller = Get.put(PinVerificationController());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      email = args['email'] ?? '';
    } else if (args is String) {
      email = args;
    } else {
      email = '';
    }
  }

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
                  const SizedBox(height: 80),
                  Text('PIN Verification', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text(
                    "A 6 digit verification has been sent to your email",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
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
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    controller: _otpTEcontroller,
                    appContext: context,
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<PinVerificationController>(
                    builder: (controller) {
                      return controller.inProgress
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                        onPressed: () => _onTapSubmitButton(context),
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      );
                    },
                  ),
                   SizedBox(height: 20),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Have an account?",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: " Sign In",
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: Colors.green,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.offAllNamed(SigninScreen.routeName);
                              },
                          ),
                        ],
                      ),
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

  void _onTapSubmitButton(BuildContext context) async {
    String pin = _otpTEcontroller.text.trim();

    if (email.isEmpty || pin.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or PIN')),
      );
      return;
    }

    bool verified = await _controller.verifyPin(email, pin);
    if (verified) {
      Get.toNamed(passwordset.routeName, arguments: {'email': email, 'pin': pin});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PIN verified successfully!')),
      );
    }
  }

  @override
  void dispose() {
    _otpTEcontroller.dispose();
    super.dispose();
  }
}
