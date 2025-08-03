import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/controllers/forgetpass_email_controller.dart';
import '../widget/screen_background.dart';
import 'forget_pass_pin.dart';
class forgetpass extends StatelessWidget {
  forgetpass({super.key});
  static const String routeName = '/forget_pass';

  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ForgetPassEmailController _controller = Get.find();

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
                  Text('Your Email Address', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text(
                    "Enter Your Email",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      if (!EmailValidator.validate(value ?? '')) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<ForgetPassEmailController>(
                    builder: (controller) {
                      return controller.inProgress
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                        onPressed: () => _onTapSubmitButton(context),
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
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
                                Navigator.pop(context);
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
    if (_formKey.currentState?.validate() ?? false) {
      bool success = await _controller.sendRecoveryEmail(_emailController.text.trim());
      if (success) {
        Get.toNamed(
          pinverification.routeName,
          arguments: {'email': _emailController.text.trim()},
        );
      }
    }
  }
}
